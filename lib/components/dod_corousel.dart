import 'package:corousel/components/dod_card.dart';
import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DodCorousel extends StatefulWidget {
  final List<Product> items;
  final Function(Product) onSwipeDown;

  const DodCorousel({
    super.key,
    required this.items,
    required this.onSwipeDown,
  });

  @override
  State<DodCorousel> createState() => _DodCorouselState();
}

class _DodCorouselState extends State<DodCorousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void didUpdateWidget(DodCorousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget$oldWidget");
    // Adjust current index if items were removed
    if (widget.items.length != oldWidget.items.length) {
          print("getting lenghth ${widget.items.length}");

      if (_currentIndex >= widget.items.length) {
        _currentIndex = widget.items.length > 0 ? widget.items.length - 1 : 0;
      }
      // Animate to new position if needed
      if (widget.items.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            _carouselController.animateToPage(
              _currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          } catch (e) {
            // Controller might not be ready yet
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 19),
        height: 330,
        child: const Center(
          child: Text(
            'No more items',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    print("getting currentIndex $_currentIndex");

    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      child: CarouselSlider.builder(
        key: ValueKey(widget.items.length),
        carouselController: _carouselController,
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: 330,
          viewportFraction: 0.7,
          clipBehavior: Clip.none,
          
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index, realIndex) {
          return DodCard(
            isActive: index == _currentIndex,
            currentIndex: index,
            activeIndex: _currentIndex,
            totalItems: widget.items.length,
            product: widget.items[index],
            onSwipeDown: widget.onSwipeDown,
          );
        },
      ),
    );
  }
}
