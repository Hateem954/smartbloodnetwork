import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Width Percentage
  double wp(double percent) {
    return width * percent / 100;
  }

  // Height Percentage
  double hp(double percent) {
    return height * percent / 100;
  }

  // Text Scale
  double sp(double size) {
    return (width / 375) * size;
  }
}
