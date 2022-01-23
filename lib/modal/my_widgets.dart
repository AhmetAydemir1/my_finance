import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_finance/modal/card_modal.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import '../main.dart';
import 'crypto_modal.dart';
import 'my_block.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyWidgets {
  BuildContext context;

  MyWidgets(this.context);

  Widget cardWidget(CreditCard card) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        padding: EdgeInsets.all(MyBlock(context).horizontal(20)),
        decoration: BoxDecoration(
          color: const Color(0xff2BC680),
          borderRadius: BorderRadius.circular(MyBlock(context).horizontal(20)),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.gripfire,
                        size: MyBlock(context).horizontal(17),
                      ),
                      SizedBox(
                        width: MyBlock(context).horizontal(100),
                      ),
                      Text(
                        card.name!,
                        style: GoogleFonts.orbitron(
                            color: backgroundColor,
                            fontSize: MyBlock(context).horizontal(25),
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MyBlock(context).horizontal(50)),
                    child: AdvancedSwitch(
                      controller: card.cardSwitch,
                      activeColor: backgroundColor,
                      thumb: Container(
                        width: MyBlock(context).horizontal(24),
                        height: MyBlock(context).horizontal(24),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff2BC680)),
                      ),
                      inactiveColor: backgroundColor,
                      width: MyBlock(context).horizontal(13),
                      height: MyBlock(context).horizontal(22),
                      enabled: true,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: MyBlock(context).horizontal(12),
                        width: MyBlock(context).horizontal(12),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: backgroundColor, width: 2)),
                      ),
                      Positioned(
                        left: MyBlock(context).horizontal(17),
                        child: Container(
                          height: MyBlock(context).horizontal(12),
                          width: MyBlock(context).horizontal(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: backgroundColor, width: 2)),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "**** " + card.number!.split(" ").last,
                    style: GoogleFonts.orbitron(
                        color: backgroundColor,
                        fontSize: MyBlock(context).horizontal(19),
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cryptoWidget(CryptoModal crypto, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MyBlock(context).horizontal(20)),
      child: AspectRatio(
        aspectRatio: 3 / 4.1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
              left: MyBlock(context).horizontal(20),
              right: MyBlock(context).horizontal(20),
              top: MyBlock(context).vertical(29),
              bottom: MyBlock(context).vertical(40)),
          decoration: BoxDecoration(
            color: crypto.picked!
                ? const Color(0xffF5FEFE)
                : const Color(0xff2A2A2A),
            borderRadius:
                BorderRadius.circular(MyBlock(context).horizontal(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto.name!,
                    style: GoogleFonts.orbitron(
                        color: crypto.picked! ? Colors.black : Colors.white,
                        fontSize: MyBlock(context).horizontal(30),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MyBlock(context).vertical(70),
                  ),
                  CircleAvatar(
                      radius: MyBlock(context).vertical(30),
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: MyBlock(context).vertical(50),
                        backgroundColor: Colors.black,
                        backgroundImage:
                            CachedNetworkImageProvider(crypto.imageUrl!),
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MyBlock(context).vertical(30),
                    child: FittedBox(
                        child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.orbitron(
                              color:
                                  crypto.picked! ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: "\$" +
                                  crypto.price!.truncate().toString() +
                                  ".",
                              style: const TextStyle(fontSize: 10000),
                            ),
                            TextSpan(
                              text: crypto.price!
                                  .toStringAsFixed(2)
                                  .split(".")
                                  .last,
                              style: const TextStyle(fontSize: 6000),
                            )
                          ]),
                    )),
                  ),
                  SizedBox(
                    height: MyBlock(context).vertical(200),
                  ),
                  Text(
                    timeAgo(crypto.now),
                    style: GoogleFonts.orbitron(
                        color: const Color(0xff777878),
                        fontSize: MyBlock(context).horizontal(36)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timeAgo(DateTime date) {
    var difference = DateTime.now().difference(date);

    return difference.inSeconds.toString()+" saniye önce";
  }

  Widget menuButton() {
    return Container(
      width: MyBlock(context).horizontal(11),
      height: MyBlock(context).horizontal(11),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(
            MyBlock(context).horizontal(40),
          ),
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(MyBlock(context).horizontal(150)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [menuCircle(), menuSquare()],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [menuSquare(), menuCircle()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuCircle() {
    return Container(
      height: MyBlock(context).horizontal(35),
      width: MyBlock(context).horizontal(35),
      decoration:
          BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 2)),
    );
  }

  Widget menuSquare() {
    return Container(
      height: MyBlock(context).horizontal(35),
      width: MyBlock(context).horizontal(35),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(MyBlock(context).horizontal(100)),
      ),
    );
  }
}
