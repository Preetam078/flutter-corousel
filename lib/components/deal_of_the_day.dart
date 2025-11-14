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
        // color: Colors.yellow,
        // //Wrap the OverlappedCarousel widget with SizedBox to fix a height. No need to specify width.
        // child: SizedBox(
        //   height: 300,
        //   child: CorouselBuilder(
        //     widgets: widgets, //List of widgets
        //     currentIndex: 2,
        //     onClicked: (index) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text("You clicked at $index"),
        //         ),
        //       );
        //     },
        //     obscure: 0.4,
        //     skewAngle: 0.1,
        //   ),
        // ),
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
