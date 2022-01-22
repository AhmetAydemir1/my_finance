class BillModal {
  final String? name;
  final String? id;
  final String? imageUrl;
  final double? price;
  bool? picked;
  final int? timestamp;

  BillModal({
    this.name,
    this.id,
    this.imageUrl,
    this.price,
    this.picked,
    this.timestamp,
  });

  factory BillModal.fromJson(Map<String, dynamic> json) {
    return BillModal(
      name: json["name"],
      id: json["id"],
      imageUrl: json["imageUrl"],
      price: json["price"],
      picked: json["picked"],
      timestamp: json["timestamp"],
    );
  }
}

class BillModalList {
  final List<BillModal>? billModals;

  BillModalList({
    this.billModals,
  });

  factory BillModalList.fromJson(List<dynamic> parsedJson) {
    List<BillModal> billModals =
        parsedJson.map((i) => BillModal.fromJson(i)).toList();
    return BillModalList(billModals: billModals);
  }
}
