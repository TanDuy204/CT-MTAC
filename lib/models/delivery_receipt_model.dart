

class DeliveryReceiptModel {
  final String id;
  final String location;
  final DateTime time;
  final String sender;
  final List<WasteItem> wasteItems;
  List<String> receiptImages;

  DeliveryReceiptModel({
    required this.id,
    required this.location,
    required this.time,
    required this.sender,
    required this.wasteItems,
    this.receiptImages = const [],
  });
}


class WasteItem {
  final String name;
  final String code;
  String status;
  int weight;

  WasteItem({
    required this.name,
    required this.code,
    this.status = "R",
    this.weight = 0,
  });
}
List<DeliveryReceiptModel> deliveryReceiptList = [
  DeliveryReceiptModel(
    id: "003437",
    location: "Dự Án Nhà máy sử dụng nước Thái Nhiên liệu TP.HCM giai đoạn 2",
    time: DateTime(2025, 2, 21, 9, 30),
    sender: "Công ty CP Xây Dựng Đê Kè và phát triển Nông Thôn Hải Dương",
    wasteItems: [
      WasteItem(name: "Giẻ lau TPNH", code: "180201"),
      WasteItem(name: "Dầu thải", code: "190205"),
      WasteItem(name: "Bùn thải", code: "190799"),
    ],
  ),
];