import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:frontend/models/shop_item_model.dart';
import 'package:frontend/resources/constants.dart';
import "package:http/http.dart" as http;

class ShopService with ChangeNotifier {
  static Future<bool> createItem(
    String token,
    String name,
    int qty,
  ) async {
    Uri url = Uri.parse(Constants.addShopItem);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
        body: json.encode({
          "item_name": name,
          "quantity": qty,
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

  static Future<List<ShopItem>> getItems(String token) async {
    Uri url = Uri.parse(Constants.getShopItems);
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ShopItem.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<bool> deleteShopItem(String token, int shopId) async {
    Uri url = Uri.parse(Constants.deleteShopItem + shopId.toString() + '/');
    final response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete item');
    }
  }
}
