import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_finance/modal/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

const primaryColor = Color(0xff37A173);
const secondaryColor = Color(0xffDDEE4B);
const backgroundColor = Color(0xff1B1B1B);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Finance',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff37A173),
              secondary: const Color(0xffDDEE4B)),
          scaffoldBackgroundColor: backgroundColor),
      home: const MyNavBar(),
    );
  }
}


