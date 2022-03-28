import 'package:frontend/models/product_model.dart';

class Item {
  final String barcode;
  final DateTime expiryDate;
  final DateTime purchasedDate;

  const Item({
    required this.barcode,
    required this.expiryDate,
    required this.purchasedDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      barcode: json['barcode'],
      expiryDate: json['expiry_date'],
      purchasedDate: json['purchased_date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'expiry_date': expiryDate,
      'purchased_date': purchasedDate,
    };
  }
}
