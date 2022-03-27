import 'nutriment_model.dart';

class Product {
  final String productName;
  final String? quantity;
  final String? productQuantity;
  final String imageUrl;
  final Nutriments? nutriments;
  final String barcode;

  const Product({
    required this.productName,
    this.quantity,
    this.productQuantity,
    this.nutriments,
    required this.imageUrl,
    required this.barcode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      productQuantity: json['product_quantity'],
      imageUrl: json['image_url'],
      nutriments: json['nutriments'] = Nutriments.fromJson(
        json['nutriments'],
      ),
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'id': barcode,
      'product_name': productName,
      'quantity': quantity,
      'product_quantity': productQuantity,
      'image_url': imageUrl,
      'nutriments': nutriments,
    };
  }
}
