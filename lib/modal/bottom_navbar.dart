import 'package:flutter/material.dart';
import 'package:my_finance/UI/home_page.dart';
import 'package:my_finance/main.dart';
import 'package:my_finance/modal/my_block.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key}) : super(key: key);

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  List<Widget> pageList = [
    const MyHomePage(),
    const Center(
      child: Text(
        "2",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text("3", style: TextStyle(color: Colors.white)),
    ),
  ];
  int currentIndex = 0;

  List<Map<String, dynamic>> navbarItems = [
    {
      "title": "home",
      "icon": Icons.home_rounded,
    },
    {
      "title": "chart",
      "icon": Icons.pie_chart_rounded,
    },
    {
      "title": "text",
      "icon": Icons.text_snippet_rounded,
    },
    {
      "title": "text",
      "icon": Icons.text_snippet_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          pageList[currentIndex],
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(MyBlock(context).horizontal(30)),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MyBlock(context).horizontal(30)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MyBlock(context).horizontal(20)),
                        color: const Color(0xff1A201E)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: navbarItems.map((item) {
                        int index = navbarItems
                            .indexWhere((element) => element == item);
                        return Opacity(
                          opacity: index != 3 ? 1 : 0,
                          child: InkWell(
                            onTap: () {
                              if (index != 3) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(index != 0
                                  ? MyBlock(context).horizontal(30)
                                  : 0),
                              child: Icon(
                                item["icon"],
                                size: MyBlock(context).horizontal(15),
                                color: currentIndex == index
                                    ? primaryColor
                                    : const Color(0xff484D4C),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    top: MyBlock(context).horizontal(5.3),
                    left: MyBlock(context).horizontal(currentIndex == 0
                        ? 8.65
                        : currentIndex == 1
                            ? 3.22
                            : 1.865),
                    child: Container(
                        height: MyBlock(context).horizontal(50),
                        width: MyBlock(context).horizontal(50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                            color: secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: secondaryColor.withOpacity(0.4),
                                  offset: const Offset(0, -2),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ])),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    right: MyBlock(context).horizontal(10),
                    bottom: MyBlock(context).horizontal(9)),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(MyBlock(context).horizontal(90)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        color: secondaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: secondaryColor.withOpacity(0.4),
                              offset: const Offset(2, 3),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ]),
                    child: Container(
                      padding: EdgeInsets.all(MyBlock(context).horizontal(30)),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                          color: secondaryColor),
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: secondaryColor),
                        child: Icon(
                          Icons.add,
                          size: MyBlock(context).horizontal(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
