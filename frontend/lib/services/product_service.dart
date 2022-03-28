import "dart:convert";
import "dart:io";
import "package:frontend/models/http_response.dart";
import "package:frontend/models/product_model.dart";
import "package:frontend/models/product_response.dart";
import "package:frontend/resources/constants.dart";
import "package:http/http.dart" as http;

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
        return HTTPResponse(
            false, ProductResponse(status: 0), "error", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(
          false, ProductResponse(status: 0), "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(
          false, ProductResponse(status: 0), "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(
          false, ProductResponse(status: 0), "Error Occurred", 400);
    }
  }

  Future<HTTPResponse<String>> addProduct(String token, Product product) async {
    Uri url = Uri.parse(Constants.addProductUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return HTTPResponse(true, response.body, "Successfully added product",
            response.statusCode);
      } else {
        return HTTPResponse(false, response.body, "error", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, "", "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, "", "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, "", "Error Occurred", 400);
    }
  }

  Future<HTTPResponse<Product?>> getProduct(String barcode) async {
    Uri url = Uri.parse(Constants.getProduct + barcode + "/");

    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        Product product = Product.fromJson(body);

        return HTTPResponse(
            true, product, "Fetched Successfully", response.statusCode);
      } else {
        return HTTPResponse(
            false, null, "Failed to get product", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, null, "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, null, "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, null, "Error Occurred", 400);
    }
  }
}
