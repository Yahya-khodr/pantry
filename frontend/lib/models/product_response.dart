
import 'package:frontend/models/product_model.dart';

class ProductData {
  Product? product;
  final int status;

  ProductData( {
    this.product, required this.status,
  });
  factory ProductData.fromJson(Map<String, dynamic> jsonData) {
    return ProductData(
      product: jsonData['product'] = Product.fromJson(
        jsonData['product'],
      ),
      status: jsonData['status']
    );
  }
}
