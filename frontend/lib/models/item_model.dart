import 'dart:convert';

import 'package:frontend/models/product_model.dart';

List<Item> itemsListModelFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemsListModelToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  final String? barcode;
  Product? product;
  final String expiryDate;
  final String purchasedDate;

   Item({
    required this.barcode,
    required this.expiryDate,
    required this.purchasedDate,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      barcode: json['barcode'],
      expiryDate: json['expiry_date'].toString(),
      purchasedDate: json['purchased_date'].toString(),
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'expiry_date': expiryDate,
      'purchased_date': purchasedDate,
      'product' : product!.toJson(),
    };
  }
}

