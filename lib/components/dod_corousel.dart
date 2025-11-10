import 'package:corousel/components/dod_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DodCorousel extends StatefulWidget {
  const DodCorousel({super.key});

  @override
  State<DodCorousel> createState() => _DodCorouselState();
}

class _DodCorouselState extends State<DodCorousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        options: CarouselOptions(
          height: 330,
          viewportFraction: 0.7,
          clipBehavior: Clip.none,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          return DodCard(
            isActive: index == _currentIndex,
            currentIndex: index,
            activeIndex: _currentIndex,
            totalItems: 5,
          );
        },
      ),
    );
  }
}
