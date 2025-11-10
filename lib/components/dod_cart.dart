import 'package:flutter/material.dart';
import 'package:corousel/product_model.dart';

class DodCart extends StatelessWidget {
  final List<Product> cartItems;
  
  const DodCart({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {  
    return SizedBox(
      width: 300,
      height: 150,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF0B4475),
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Cart is empty',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            product.imageAsset,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image, color: Colors.white70);
                            },
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '₹${product.price}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        );
                      },
                    ),
            )
          )
        ],
      ),
    );
  }
}