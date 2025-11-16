import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;

  List<Product> items = [
    Product(
      id: 1,
      name: 'HUBBERHOLME',
      description: 'beige and linen\nformal look',
      price: 3000,
      originalPrice: 5499,
      imageAsset: 'lib/assets/images/sample.png',
    ),
    Product(
      id: 2,
      name: 'Product 2',
      description: 'Description 2',
      price: 4000,
      originalPrice: 6000,
      imageAsset: 'lib/assets/images/sample.png',
    ),
    Product(
      id: 3,
      name: 'Product 3',
      description: 'Description 3',
      price: 2500,
      originalPrice: 4000,
      imageAsset: 'lib/assets/images/sample.png',
    ),
    Product(
      id: 4,
      name: 'Product 4',
      description: 'Description 4',
      price: 8000,
      originalPrice: 10000,
      imageAsset: 'lib/assets/images/sample.png',
    ),
    Product(
      id: 5,
      name: 'Product 5',
      description: 'Description 5',
      price: 1500,
      originalPrice: 2000,
      imageAsset: 'lib/assets/images/sample.png',
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Center the first item after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && items.isNotEmpty) {
        _snapToCenter(1);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    // Calculate which item is centered
    final scrollOffset = _scrollController.offset;
    final itemWidth = 160.0 + 16.0; // width + padding (160 width + 16 right padding)
    final padding = 20.0; // horizontal padding
    final viewportWidth = _scrollController.position.viewportDimension;
    final centerX = viewportWidth / 2;
    
    // Calculate the index of the item closest to center
    // The center point in the scrollable content is at: scrollOffset + centerX
    // An item at index i has its center at: padding + i * itemWidth + 80
    // So we solve: scrollOffset + centerX = padding + i * itemWidth + 80
    // i = (scrollOffset + centerX - padding - 80) / itemWidth
    final centerItemIndex = ((scrollOffset + centerX - padding - 80.0) / itemWidth).round();
    
    final newActiveIndex = centerItemIndex.clamp(0, items.length - 1);
    
    if (newActiveIndex != _activeIndex) {
      setState(() {
        _activeIndex = newActiveIndex;
      });
    }
  }

  void _snapToCenter(int index) {
    if (!_scrollController.hasClients) return;
    
    final itemWidth = 160.0 + 16.0; // width + padding (160 width + 16 right padding)
    final padding = 20.0; // horizontal padding
    final viewportWidth = _scrollController.position.viewportDimension;
    final centerX = viewportWidth / 2;
    
    // Calculate target scroll position to center the item
    // Item's left edge: padding + index * itemWidth
    // Item's center: padding + index * itemWidth + itemWidth/2 - 16/2 (accounting for right padding)
    // Actually simpler: item center is at padding + index * itemWidth + 80 (half of 160)
    final itemCenterX = padding + (index * itemWidth) + 80.0;
    final targetOffset = itemCenterX - centerX;
    
    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

void removeItem(int index) async {
  if (index < 0 || index >= items.length) return;

  final removedItem = items[index];
  items.removeAt(index);

  // Update active index if needed
  if (index == _activeIndex && items.isNotEmpty) {
    // Keep the same index (which now points to the next item)
    // or adjust if we removed the last item
    if (_activeIndex >= items.length) {
      _activeIndex = items.length - 1;
    }
    // After removal animation, snap to center
    Future.delayed(Duration(milliseconds: 400), () {
      if (mounted) {
        _snapToCenter(_activeIndex);
      }
    });
  } else if (index < _activeIndex) {
    // If we removed an item before the active one, adjust the index
    _activeIndex--;
  }

  _listKey.currentState?.removeItem(
    index,
    (context, animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: 0, // 👈 instantly invisible
            child: SizedBox(
              width: 160 * animation.value, // 👈 only width shrinks
              child: child,
            ),
          );
        },
        child: _buildItem(
          removedItem,
          index,
          kAlwaysCompleteAnimation,   // static content inside
        ),
      );
    },
    duration: Duration(milliseconds: 350),
  );
}


  Widget _buildItem(Product item, int index, Animation<double> animation) {
    double offsetY = 0.0;
    bool isActive = index == _activeIndex; // Only the centered item is active

    return StatefulBuilder(
      builder: (context, setStateSB) {
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: GestureDetector(
            onVerticalDragUpdate: isActive
                ? (details) {
                    setStateSB(() {
                      offsetY += details.delta.dy;

                      if (offsetY < 0) offsetY = 0;
                      // if (offsetY > 60) offsetY = 60;
                    });
                  }
                : null,
            onVerticalDragEnd: isActive
                ? (_) {
                    if (offsetY > 150) {
                      removeItem(index);
                    } else {
                      setStateSB(() => offsetY = 0);
                    }
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.amber,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 48, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        "ONLY 2 LEFT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Index: $index',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: items.isEmpty
          ? Center(
              child: Text(
                'No items left!',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  // Snap to center after scrolling ends
                  _snapToCenter(_activeIndex);
                }
                return false;
              },
              child: AnimatedList(
                key: _listKey,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20),
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(items[index], index, animation);
                },
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null) return _buildCarousel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Carousel'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          _buildCarousel(),
        ],
      ),
    );
  }
}
