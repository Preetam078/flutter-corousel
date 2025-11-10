import 'package:corousel/card_item.dart';
import 'package:corousel/cart.dart';
import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class CorouselScreen extends StatefulWidget {
  const CorouselScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CorouselScreenState createState() => _CorouselScreenState();
}

class _CorouselScreenState extends State<CorouselScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.7,
    initialPage: 0,
  );
  final List<Product> _carouselItems = [
    Product(
      id: 1,
      name: 'HUBBERHOLME',
      description: 'beige and linen\nformal look',
      price: 3000,
      originalPrice: 5499,
      imageAsset: 'lib/assets/images/fetching_cards.png',
    ),
    Product(
      id: 2,
      name: 'Product 2',
      description: 'Description 2',
      price: 4000,
      originalPrice: 6000,
      imageAsset: 'lib/assets/images/fetching_cards.png',
    ),
    Product(
      id: 3,
      name: 'Product 3',
      description: 'Description 3',
      price: 2500,
      originalPrice: 4000,
      imageAsset: 'lib/assets/images/fetching_cards.png',
    ),
    Product(
      id: 4,
      name: 'Product 4',
      description: 'Description 4',
      price: 8000,
      originalPrice: 10000,
      imageAsset: 'lib/assets/images/fetching_cards.png',
    ),
    Product(
      id: 5,
      name: 'Product 5',
      description: 'Description 5',
      price: 1500,
      originalPrice: 2000,
      imageAsset: 'lib/assets/images/fetching_cards.png',
    ),
  ];
  List<Product> _cartItems = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // The PageView should be using the updated list length,
  // so if the item at index X is removed, the old item at X+1 is now at index X.

 void _addToCart(Product product) {
  setState(() {
    // Add to cart only if it's not already there
    if (!_cartItems.any((item) => item.id == product.id)) {
      _cartItems.add(product);

      // 1. Get the index of the product about to be removed.
      final int removedIndex = _carouselItems.indexWhere((item) => item.id == product.id);
      

      // 2. Remove the item from the carousel list.
      _carouselItems.removeWhere((item) => item.id == product.id);
      
      // 3. Update the PageView position only if items remain.
      if (_carouselItems.isNotEmpty) {
        final int newIndex = removedIndex - 1;
        // Update the state variable
        _currentPage = removedIndex - 1;

        // 4. Smoothly animate the PageView to the new index.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pageController.animateToPage(
            newIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        });
      } else {
        // If the list is now empty, set current page to a safe value.
        _currentPage = 0;
      }
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fetching_cards.png"), // <-- Your image path here
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 550, // Set a height for the carousel
                child: PageView.builder(
                  itemCount: _carouselItems.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    if (_carouselItems.isEmpty) {
                      return const Center(child: Text("No more items!"));
                    }
                    final product = _carouselItems[index];
                    // We pass the active page and the builder index to the card.
                    return ProductCard(
                      activeIndex: _currentPage,
                      currentIndex: index,
                      product: product,
                      onAddToCart: _addToCart,
                    );
                  },
                ),
              ),
              Cart(cartItems: _cartItems),
            ],
          ),
        ),
      ),
    );
  }
}
