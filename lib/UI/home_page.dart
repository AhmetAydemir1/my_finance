import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/modal/api.dart';
import 'package:my_finance/modal/crypto_modal.dart';
import 'package:my_finance/modal/card_modal.dart';
import 'package:my_finance/modal/my_widgets.dart';
import '../main.dart';
import '../modal/my_block.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double monthSpend = 1760.58;
  bool pageLoaded = false;
  double spendPercentage = 80;
  List<CreditCard> myCards = [];
  List<CryptoModal> trendCryptos = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    startSync();
  }

  startSync() async {
    myCards = CreditCardList.fromJson([
          {
            "id": "1234567890",
            "name": "Climb. card",
            "number": "1234 5678 9000 8302",
            "cardSwitch": true
          },
          {
            "id": "1234567890",
            "name": "Climb. card",
            "number": "1234 5678 9000 8302",
            "cardSwitch": true
          },
          {
            "id": "1234567890",
            "name": "Climb. card",
            "number": "1234 5678 9000 8302",
            "cardSwitch": true
          },
          {
            "id": "1234567890",
            "name": "Climb. card",
            "number": "1234 5678 9000 8302",
            "cardSwitch": true
          },
        ]).creditCards ??
        [];

    await getData();
    trendCryptos.first.picked = true;
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      await getData();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    if (mounted) {
      setState(() {
        pageLoaded = true;
      });
    }
  }

  getData() async {
    var response = await jsonDecode(await Api().get(
        "https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest",
        {
          "X-CMC_PRO_API_KEY": "b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c",
        }));
    if (response["status"]["error_code"] == 0) {
      int lastPicked = 0;
      if (trendCryptos.isNotEmpty) {
        lastPicked = trendCryptos.indexWhere((element) => element.picked!);
      }
      setState(() {
        trendCryptos =
            CryptoModalList.fromJson(response["data"]).cryptoModals ?? [];
        for (CryptoModal crypto in trendCryptos) {
          crypto.picked = false;
        }
        trendCryptos[lastPicked].picked = true;
      });
    } else {
      print(response["status"]["error_message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(MyBlock(context).horizontal(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets(context).menuButton(),
                    CircleAvatar(
                      radius: MyBlock(context).horizontal(15),
                      backgroundImage: const CachedNetworkImageProvider(
                          "https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg"),
                    )
                  ],
                ),
              ),
              bottom: false,
            ),
            SizedBox(
              height: MyBlock(context).vertical(90),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MyBlock(context).horizontal(5)),
              child: SizedBox(
                height: MyBlock(context).vertical(15),
                child: FittedBox(
                    child: RichText(
                  text: TextSpan(
                      style: GoogleFonts.orbitron(
                          color: secondaryColor, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "\$" + monthSpend.truncate().toString() + ".",
                          style: const TextStyle(fontSize: 10000),
                        ),
                        TextSpan(
                          text: monthSpend.toString().split(".").last,
                          style: const TextStyle(fontSize: 6000),
                        )
                      ]),
                ) /*Text(
                  "\$" + monthSpend.toStringAsFixed(2),
                  style:
                      const TextStyle(color: secondaryColor, fontSize: 10000),
                )*/
                    ),
              ),
            ),
            SizedBox(
              height: MyBlock(context).vertical(200),
            ),
            Text(
              "Total month spend",
              style: GoogleFonts.orbitron(color: const Color(0xff777878)),
            ),
            SizedBox(
              height: MyBlock(context).vertical(30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MyBlock(context).horizontal(15)),
              child: Stack(
                children: [
                  Container(
                    height: MyBlock(context).horizontal(50),
                    decoration: BoxDecoration(
                        color: const Color(0xff484948),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: pageLoaded
                        ? (MyBlock(context).horizontal(1) -
                                MyBlock(context).horizontal(7.5)) *
                            (spendPercentage / 100)
                        : 0,
                    height: MyBlock(context).horizontal(50),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: secondaryColor.withOpacity(0.5),
                              offset: const Offset(0, -1),
                              blurRadius: 10,
                              spreadRadius: 1)
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MyBlock(context).vertical(20),
            ),
            SizedBox(
                height: MyBlock(context).vertical(5),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyBlock(context).horizontal(50)),
                  scrollDirection: Axis.horizontal,
                  itemCount: myCards.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MyBlock(context).horizontal(35)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: MyBlock(context).horizontal(20)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MyBlock(context).horizontal(20)),
                              border:
                                  Border.all(color: primaryColor, width: 2)),
                          child: Center(
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    "Connect card",
                                    style: GoogleFonts.orbitron(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            MyBlock(context).horizontal(24)),
                                  ))),
                        ),
                      );
                    } else {
                      index = index - 1;
                      return Row(
                        children: [
                          MyWidgets(context).cardWidget(myCards[index]),
                          SizedBox(
                            width: MyBlock(context).horizontal(35),
                          ),
                        ],
                      );
                    }
                  },
                )),
            trendCryptos.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: MyBlock(context).vertical(19),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MyBlock(context).vertical(36)),
                            child: Text(
                              "Trending cryptos",
                              style: GoogleFonts.orbitron(
                                  fontSize: MyBlock(context).vertical(30),
                                  color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        height: MyBlock(context).vertical(50),
                      ),
                      SizedBox(
                          height: MyBlock(context).vertical(4),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: MyBlock(context).horizontal(17)),
                            scrollDirection: Axis.horizontal,
                            itemCount: trendCryptos.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  MyWidgets(context)
                                      .cryptoWidget(trendCryptos[index], () {
                                    for (CryptoModal bill in trendCryptos) {
                                      bill.picked = false;
                                    }
                                    setState(() {
                                      trendCryptos[index].picked = true;
                                    });
                                  }),
                                  trendCryptos.length - 1 != index
                                      ? SizedBox(
                                          width:
                                              MyBlock(context).horizontal(35),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              );
                            },
                          )),
                    ],
                  )
                : const SizedBox.shrink(),
            SafeArea(
              child: SizedBox(
                height: MyBlock(context).vertical(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
