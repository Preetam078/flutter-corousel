import 'package:corousel/components/custom_corousel.dart';
import 'package:corousel/components/deal_of_the_day.dart';
import 'package:corousel/corousel_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'Users List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DealOfTheDay()
        //home:   CustomCorousel(),
    );
  }
}