import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  final ValueChanged<bool> onCartHandleMove;
  final List<Product> carItems;


  const CarouselDemo(
      {super.key,
      required this.onCartHandleMove,
      required this.carItems,
    });

  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {

  late PageController _pageController;
  int _activeIndex = 0;
  int? _removingIndex;

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.5,
      initialPage: 0,
    );
    _pageController.addListener(_onPageScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageScroll() {
    if (!_pageController.hasClients || items.isEmpty) return;

    final page = _pageController.page ?? 0;
    final newActiveIndex = page.round().clamp(0, items.length - 1);

    if (newActiveIndex != _activeIndex) {
      setState(() => _activeIndex = newActiveIndex);
    }
  }

  void removeItem(int index) async {
    if (items.isEmpty) return;

    setState(() => _removingIndex = index);

    await Future.delayed(Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      widget.carItems.add(items[index]);
      items.removeAt(index);
      _removingIndex = null;
    });

    if (items.isEmpty) return;

    // Adjust active index if needed
    if (_activeIndex >= items.length) {
      _activeIndex = items.length - 1;
    }

    // Animate to the adjusted position
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _activeIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildItem(Product item, int index) {
    double offsetY = 0.0;
    bool isActive = index == _activeIndex;
    bool isRemoving = _removingIndex == index;

    return StatefulBuilder(
      builder: (context, setStateSB) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: isRemoving ? 0 : 160,
          child: Transform.translate(
            offset: Offset(0, offsetY),
            child: GestureDetector(
              onVerticalDragUpdate: isActive && !isRemoving
                  ? (details) {
                      setStateSB(() {
                        offsetY += details.delta.dy;
                        if (offsetY < 0) offsetY = 0;
                      });
                    }
                  : null,

              onVerticalDragEnd: isActive && !isRemoving
                  ? (_) {
                      if (offsetY > 60) {
                        // Use the callback to notify the parent
                        widget.onCartHandleMove(true);
                      }
                      if (offsetY > 150) {
                        setStateSB(() => offsetY = 0);
                        removeItem(index);
                      } else {
                        setStateSB(() => offsetY = 0);
                      }
                    }
                  : null,

              onTap: !isActive && !isRemoving
                  ? () {
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  : null,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 0),
                  opacity: isRemoving ? 0 : 1,
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.blue,
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
                            'Item: ${item.name}',
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
          : PageView.builder(
              clipBehavior: Clip.none,
              controller: _pageController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildItem(items[index], index);
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null) return _buildCarousel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Carousel'),
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