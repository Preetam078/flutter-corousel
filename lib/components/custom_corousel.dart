import 'package:corousel/components/dod_card.dart';
import 'package:corousel/components/dod_cardv2.dart';
import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class CustomCorousel extends StatelessWidget {
  const CustomCorousel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Corousel();
  }
}

class Corousel extends StatefulWidget {
  const Corousel({super.key});

  @override
  State<StatefulWidget> createState() => _CorouselState();
}

class _CorouselState extends State<Corousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

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

  @override
  Widget build(BuildContext context) {
    final List<Product> _carouselItems = [
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

    return PageView.builder(
      controller: _pageController,
      itemCount: _carouselItems.length,
      itemBuilder: (context, index) {
        // return DodCardV2(
        // isActive: _currentPage == index,
        // currentIndex: index,
        // activeIndex: _currentPage,
        // totalItems: _carouselItems.length,
        // product: _carouselItems[index],
        // onSwipeDown: (product) {  },
        // );
        return _buildCorouselItem(_carouselItems[index].imageAsset, index);
      },
    );
  }

  Widget _buildCorouselItem(String imageUrl, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: _currentPage == index ? 10 : 60,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        )
      ),

    );
  }

}
