import 'package:corousel/components/sample_card.dart';
import 'package:corousel/product_model.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final List<Product> cartItems;

  const CartItems({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cartItems.asMap().entries.map((entry) {
        int index = entry.key;
        Product product = entry.value;
        
        return Positioned(
          top: 0 + (index * 10.0), // Adjust spacing as needed
          left: 0,
          right: 0,
          child: SampleCard(
            // Pass product data if SampleCard accepts it
            // product: product,
          ),
        );
      }).toList(),
    );
  }
}