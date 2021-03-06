import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/resources/constants.dart';
import "package:http/http.dart" as http;

class FoodService with ChangeNotifier {
  static Future<bool> addFood(
      String token,
      String barcode,
      String name,
      String qty,
      String expDate,
      String purDate,
      String category,
      File imageFile) async {
    Uri url = Uri.parse(Constants.addFoodUrl);
    String base64file = base64Encode(imageFile.readAsBytesSync());
    String fileName = imageFile.path.split("/").last;
    Map headerData = {};
    headerData['image_name'] = fileName;
    headerData['file'] = base64file;
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
        body: json.encode({
          "barcode": barcode,
          "name": name,
          "quantity": qty,
          "expiry_date": expDate,
          "purchased_date": purDate,
          "category": category,
          "image_name": fileName,
          "file": base64file,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<Food>> getFoods(String token) async {
    Uri url = Uri.parse(Constants.getFoodsUrl);
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Food.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<List<Food>> getRecentFoods(String token) async {
    Uri url = Uri.parse(Constants.getRecentFoodsUrl);
    final response = await http.get(url, headers: {
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Food.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
  static Future<List<Food>> getExpiredFoods(String token) async {
    Uri url = Uri.parse(Constants.getExpiredFoodsUrl);
    final response = await http.get(url, headers: {
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Food.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<List<Food>> getFoodsByCategory(
      String token, String category) async {
    Uri url = Uri.parse(Constants.getFoodByCategoryUrl + category + '/');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token " + token,
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Food.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<HTTPResponse<String>> removeFood(int id, String token) async {
    Uri url = Uri.parse(Constants.removeFoodUrl + id.toString() + '/');
    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
      );
      if (response.statusCode == 200) {
        return HTTPResponse(
            true, "Food Updated", "Food Updated", response.statusCode);
      } else {
        return HTTPResponse(false, "Failed to Update Food",
            "Failed to Update Food", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, "", "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, "", "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, "", "Error Occurred", 400);
    }
  }

  static Future<HTTPResponse<String>> increaseFoodQuantity(
      int id, String token) async {
    Uri url = Uri.parse(Constants.increaseFood + id.toString() + '/');
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
      );
      if (response.statusCode == 200) {
        return HTTPResponse(
            true, "Food Updated", "Food Updated", response.statusCode);
      } else {
        return HTTPResponse(false, "Failed to Food Cart", "Failed to Food Food",
            response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, "", "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, "", "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, "", "Error Occurred", 400);
    }
  }

  static Future<HTTPResponse<String>> decreaseFoodQuantity(
      int id, String token) async {
    Uri url = Uri.parse(Constants.decreaseFood + id.toString() + '/');
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
      );
      if (response.statusCode == 200) {
        return HTTPResponse(
            true, "Food Updated", "Food Updated", response.statusCode);
      } else {
        return HTTPResponse(false, "Failed to Food Cart",
            "Failed to Update Food", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, "", "No Internet Connection", 400);
    } on FormatException {
      return HTTPResponse(false, "", "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, "", "Error Occurred", 400);
    }
  }
}
