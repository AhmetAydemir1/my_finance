import 'package:flutter/material.dart';

class MyBlock {
  BuildContext context;

  MyBlock(this.context);

  double vertical(double x) {
    return MediaQuery.of(context).size.height / x;
  }

  double horizontal(double x) {
    return MediaQuery.of(context).size.width / x;
  }
}
