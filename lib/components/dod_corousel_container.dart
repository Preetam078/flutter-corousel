import 'package:corousel/components/custom_corousel.dart';
import 'package:corousel/components/dod_action_info.dart';
import 'package:corousel/components/dod_cart.dart';
import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class DodCorouselContainer extends StatefulWidget {
  const DodCorouselContainer({super.key});

  @override
  State<DodCorouselContainer> createState() => _DodCorouselContainerState();
}

class _DodCorouselContainerState extends State<DodCorouselContainer> {
  List<Product> _carouselItems = [
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
  List<Product> _cartItems = [];

  @override
  Widget build(BuildContext context) {
    print("getting Data.......$_carouselItems");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            DodActionInfo(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselDemo(),
                // DodCorousel(
                //   items: _carouselItems,
                //   onSwipeDown: _onSwipeDown,
                // ),
                const SizedBox(height: 60),
              ],
            ),
          ],
        ),
        DodCart(cartItems: _cartItems),
      ],
    );
  }
}
