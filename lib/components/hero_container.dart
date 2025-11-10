import 'package:flutter/material.dart';

class HeroContainer extends StatelessWidget {
  const HeroContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              "home needs",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Denton",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SizedBox(
                width: 200,
                child: Text(
                  "shop at exclusive discounts before the timer runs out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Denton",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
