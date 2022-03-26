
import 'package:frontend/models/product_model.dart';

class ProductResponse {
  Product? product;
  final int status;

  ProductResponse( {
    this.product, required this.status,
  });
  factory ProductResponse.fromJson(Map<String, dynamic> jsonData) {
    return ProductResponse(
      product: jsonData['product'] = Product.fromJson(
        jsonData['product'],
      ),
      status: jsonData['status']
    );
  }
}
