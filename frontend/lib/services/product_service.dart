import 'dart:convert';

import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/product_response.dart';
import 'package:frontend/resources/constants.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<ProductResponse> fetchProduct(String barcode) async {
    Uri url = Uri.parse(Constants.remoteApi + barcode);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get product Info');
    }
  }
}
