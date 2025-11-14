import 'package:corousel/components/deal_of_the_day.dart';
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
        //home: CorouselDemo(),
    );
  }
}