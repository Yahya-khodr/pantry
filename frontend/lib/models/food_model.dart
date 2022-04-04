import 'package:frontend/resources/constants.dart';

class Food {
  int? id;
  String? barcode;
  String? expiryDate;
  String? purchasedDate;
  int? category;
  String? name;
  String? quantity;
  String? imageUrl;
  int? total;

  Food(
      {this.id,
      this.barcode,
      this.expiryDate,
      this.purchasedDate,
      this.category,
      this.name,
      this.imageUrl,
      this.total,
      this.quantity});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    expiryDate = json['expiry_date'];
    purchasedDate = json['purchased_date'];
    category = json['category'];
    name = json['name'];
    quantity = json['quantity'];
    total = json['total'];
    imageUrl = json['image'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['barcode'] = barcode;
    data['expiry_date'] = expiryDate;
    data['purchased_date'] = purchasedDate;
    data['category'] = category;
    data['name'] = name;
    data['quantity'] = quantity;
    data['image'] = imageUrl;
    data['total'] = total;
    return data;
  }
}
