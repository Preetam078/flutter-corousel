import 'package:flutter/material.dart';

class SampleCard extends StatelessWidget{
  const SampleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      color: Colors.white,
      child: Text("Hello"),
    );
  }
}