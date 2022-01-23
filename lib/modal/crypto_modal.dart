class CryptoModal {
  final String? name;
  final String? id;
  final String? imageUrl;
  final double? price;
  bool? picked;

  //latestUpdate apidaki güncellemeyi gösteriyor yani veriyi daha
  //yeni almış bile olsam 1 dk önce güncellendi olarak gözüküyor.
  final String? latestUpdate;

  //bu nedenle now verisini ekledim ve mantık olarak
  //en son api isteğinin zamanını gösteriyor
  final DateTime now = DateTime.now();

  CryptoModal({
    this.name,
    this.id,
    this.imageUrl,
    this.price,
    this.picked,
    this.latestUpdate,
  });

  factory CryptoModal.fromJson(Map<String, dynamic> json) {
    return CryptoModal(
      name: json["name"],
      id: json["id"].toString(),
      imageUrl: "https://s2.coinmarketcap.com/static/img/coins/64x64/${json["id"].toString()}.png",
      price: json["quote"]["USD"]["price"],
      picked: json["picked"],
      latestUpdate: json["last_updated"],
    );
  }
}

class CryptoModalList {
  final List<CryptoModal>? cryptoModals;

  CryptoModalList({
    this.cryptoModals,
  });

  factory CryptoModalList.fromJson(List<dynamic> parsedJson) {
    List<CryptoModal> cryptoModals =
        parsedJson.map((i) => CryptoModal.fromJson(i)).toList();
    return CryptoModalList(cryptoModals: cryptoModals);
  }
}
