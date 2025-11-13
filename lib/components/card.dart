import 'package:flutter/cupertino.dart';

class CardModel {
  final int id;
  double rotationAngle;
  bool isDragable;
  final Widget? child;

  CardModel({
    required this.id,
    this.rotationAngle = 0.0,
    this.isDragable = false,
    this.child,
  });
}

