import 'package:flutter/material.dart';

class DodCart extends StatelessWidget {
  const DodCart({super.key});

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
              color: Color(0xFF0B4475),
            )
          )
        ],
      ),
    );
  }
}