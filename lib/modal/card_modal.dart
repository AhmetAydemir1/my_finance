import 'package:flutter/cupertino.dart';

class CreditCard {
  final String? name;
  final String? id;
  final String? number;
  final ValueNotifier<bool>? cardSwitch;

  CreditCard({this.name, this.id, this.number, this.cardSwitch});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      name: json["name"],
      id: json["id"],
      number: json["number"],
      cardSwitch: ValueNotifier<bool>(json["cardSwitch"]),
    );
  }
}

class CreditCardList {
  final List<CreditCard>? creditCards;

  CreditCardList({
    this.creditCards,
  });

  factory CreditCardList.fromJson(List<dynamic> parsedJson) {
    List<CreditCard> creditCards =
        parsedJson.map((i) => CreditCard.fromJson(i)).toList();
    return CreditCardList(creditCards: creditCards);
  }
}
