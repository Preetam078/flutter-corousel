import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(children: _navbarWidgets()),
    );
  }

  List<Widget> _navbarWidgets() {
    return [
      GestureDetector(
        onTap: () {
          print("Cross Operation");
        },
        child: Text(
          "x",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          print("Info Operation");
        },
        child: Text(
          "i",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }
}
