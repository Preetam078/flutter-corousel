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
  
  // Track items locally for AnimatedList
  late List<Product> _displayedItems;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _displayedItems = List.from(widget.items);
  }

  @override
  void didUpdateWidget(DodCorousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Check if an item was removed
    if (widget.items.length < oldWidget.items.length && !_isRemoving) {
      _handleItemRemoval(oldWidget.items);
    } else if (widget.items.length != _displayedItems.length) {
      // Sync with parent if items changed externally
      setState(() {
        _displayedItems = List.from(widget.items);
      });
    }
  }

  void _handleItemRemoval(List<Product> oldItems) async {
    _isRemoving = true;
    
    // Find which item was removed
    final removedItem = oldItems.firstWhere(
      (item) => !widget.items.contains(item),
      orElse: () => oldItems[_currentIndex],
    );
    
    final removedIndex = _displayedItems.indexWhere((item) => item.id == removedItem.id);
    
    if (removedIndex == -1) {
      _isRemoving = false;
      return;
    }

    // Remove from displayed items
    _displayedItems.removeAt(removedIndex);

    // Adjust current index
    if (_currentIndex >= _displayedItems.length && _displayedItems.isNotEmpty) {
      _currentIndex = _displayedItems.length - 1;
    } else if (_displayedItems.isEmpty) {
      _currentIndex = 0;
    }

    // Animate to new position after removal
    if (_displayedItems.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
      try {
        _carouselController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } catch (e) {
        // Controller might not be ready
      }
    }

    setState(() {});
    
    await Future.delayed(const Duration(milliseconds: 400));
    _isRemoving = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_displayedItems.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 19),
        height: 330,
        child: const Center(
          child: Text(
            'No more items',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      child: CarouselSlider.builder(
        key: ValueKey(_displayedItems.length),
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
        itemCount: _displayedItems.length,
        itemBuilder: (context, index, realIndex) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: DodCard(
              key: ValueKey(_displayedItems[index].id),
              isActive: index == _currentIndex,
              currentIndex: index,
              activeIndex: _currentIndex,
              totalItems: _displayedItems.length,
              product: _displayedItems[index],
              onSwipeDown: widget.onSwipeDown,
            ),
          );
        },
      ),
    );
  }
}