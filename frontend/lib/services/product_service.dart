import 'dart:convert';
import 'dart:io';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/product_response.dart';
import 'package:frontend/resources/constants.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<HTTPResponse<ProductResponse>> fetchProduct(String barcode) async {
    Uri url = Uri.parse(Constants.remoteApi + barcode);
  try {
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return HTTPResponse(
          true,
          ProductResponse.fromJson(jsonDecode(response.body)),
          "Success",
          response.statusCode);
    } else {
        
        return HTTPResponse(false, ProductResponse(status: 0 ), 'error', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, ProductResponse(status: 0 ), "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, ProductResponse(status: 0 ), "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false,ProductResponse(status: 0 ), "Error Occurred", 400);
    }
  }
}
