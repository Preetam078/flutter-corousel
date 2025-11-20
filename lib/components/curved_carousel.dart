import 'package:corousel/components/item.dart';
import 'package:flutter/material.dart';
import 'carousel_card.dart';
import 'draggable_carousel_card.dart';

class CurvedCarousel extends StatefulWidget {
  final List<CarouselItem> items;
  final Function(CarouselItem, double) onPullDown;
  final PageController pageController;
  final Set<String> hiddenItems;
  final Animation<double>? gapAnimation;
  final int removedIndex;

  const CurvedCarousel({
    Key? key,
    required this.items,
    required this.onPullDown,
    required this.pageController,
    this.hiddenItems = const {},
    this.gapAnimation,
    this.removedIndex = -1,
  }) : super(key: key);

  @override
  State<CurvedCarousel> createState() => _CurvedCarouselState();
}

class _CurvedCarouselState extends State<CurvedCarousel> {
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        _currentPage = widget.pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    // widget.pageController.dispose(); // Don't dispose passed controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: widget.items.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        
        if (widget.hiddenItems.contains(item.id)) {
          return const SizedBox(); // Render empty space for hidden items
        }
        
        // Calculate offset for curved effect
        double relativePosition = index - _currentPage;
        // User requested "just 5% below", assuming card height ~400, 5% is 20.
        double verticalOffset = (relativePosition.abs() * 10).clamp(0.0, 50.0);
        
        // Calculate tilt (rotation)
        // User requested "slightly tilted".
        // We'll rotate around the Z axis.
        // Left card (negative relativePosition) -> tilt left? or right?
        // Usually side cards tilt outwards.
        // Let's try a small angle proportional to distance.
        double rotationAngle = relativePosition * 0.10; // approx 3 degrees per unit

        Widget child = DraggableCarouselCard(
            key: ValueKey(item.id),
            item: item,
            isCurrent: index == _currentPage.round(),
            onPulledDown: (offset) => widget.onPullDown(item, offset),
          );
          
        // Apply rotation
        child = Transform.rotate(
          angle: rotationAngle,
          child: child,
        );

        // Apply gap closing animation
        // Items that are at or after the removed index need to slide in from the right.
        // Items before the removed index need to slide in from the left (backwards animation).
        if (widget.gapAnimation != null && widget.removedIndex != -1) {
          return AnimatedBuilder(
            animation: widget.gapAnimation!,
            builder: (context, child) {
              double width = MediaQuery.of(context).size.width * 0.55; // 0.55 is fraction
              
              // Apply easing curve for smoother animation
              final curvedValue = Curves.easeOutCubic.transform(widget.gapAnimation!.value);
              double offset = 0.0;
              
              if (index >= widget.removedIndex) {
                // Items after removed index: slide from right to left
                // Animation goes from 0.0 -> 1.0, offset goes from +width -> 0
                offset = width * (1.0 - curvedValue);
              } else {
                // Items before removed index: slide from left to right (backwards)
                // Animation goes from 0.0 -> 1.0, offset goes from -width -> 0
                offset = -width * (1.0 - curvedValue);
              }
              
              return Transform.translate(
                offset: Offset(offset, verticalOffset),
                child: child,
              );
            },
            child: child,
          );
        }

        return Transform.translate(
          offset: Offset(0, verticalOffset),
          child: child,
        );
      },
    );
  }
}
