import 'package:corousel/components/dod_action_info.dart';
import 'package:corousel/components/dod_cart.dart';
import 'package:corousel/components/dod_corousel.dart';
import 'package:flutter/material.dart';

class DodCorouselContainer extends StatelessWidget {
  const DodCorouselContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            DodActionInfo(),
            Column(
              children: [
              const DodCorousel(),
               SizedBox(height: 60)
              ]),
          ],
        ),
        DodCart(),
      ],
    );
  }
}
