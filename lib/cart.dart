import 'package:flutter/material.dart';
import 'package:corousel/product_model.dart';

class Cart extends StatelessWidget {
  final List<Product> cartItems;
  const Cart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {

    print("Continue.....$cartItems");

    return Container(
      width: 300,
      height: 170,
      child: Column(
        children: [
          Image(
            image: AssetImage("lib/assets/images/open_cart.png"),
            
          ),
          Expanded(
            child: Container(
               width: double.infinity,
               height: double.infinity,
               color: const Color(0xFF0B4475),
            ),
          )
        ],
      ),
    );
  }
}