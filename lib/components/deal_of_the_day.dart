import 'package:corousel/components/deal_status.dart';
import 'package:corousel/components/dod_corousel_container.dart';
import 'package:corousel/components/hero_container.dart';
import 'package:corousel/components/navbar.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/fetching_cards.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(child: Column(children: [Navbar(), HeroContainer(), DealStatus(shoppingCount: 19999), Spacer(), DodCorouselContainer()])),
      ),
    );
  }
}
