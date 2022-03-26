import 'nutriment_model.dart';

class Product {
  final String productName;
  final String? quantity;
  final String? productQuantity;
  final String imageUrl;
  final Nutriments? nutriments;

  const Product({
    required this.productName,
    this.quantity,
    this.productQuantity,
    this.nutriments,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      quantity: json['quantity'],
      productQuantity: json['product_quantity'],
      imageUrl: json['image_url'],
      nutriments: json['nutriments'] = Nutriments.fromJson(
        json['nutriments'],
      ),
    );
  }
}
