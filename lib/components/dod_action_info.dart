import 'package:flutter/material.dart';

class DodActionInfo extends StatelessWidget {
  const DodActionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Text("PULL DOWN TO ADD TO CART",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
          ),
          Image(image: AssetImage("lib/assets/images/down_arrow.png")),
          Padding(
            padding: EdgeInsets.only(top: 9),
            child: Image(image: AssetImage("lib/assets/images/open_cart.png"))
          )
           
        ],
      ),
    );
  }
}