import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:frontend/models/item_model.dart';
import 'package:frontend/resources/constants.dart';
import "package:http/http.dart" as http;

class ItemService with ChangeNotifier {
  static Future<bool> addItem(String token, Item item) async {
    Uri url = Uri.parse(Constants.addItemUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
        body: json.encode(item.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return false;
    } on FormatException {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Item>> fetchItems(String token) async {
    Uri url = Uri.parse(Constants.getItemsUrl);
    final response = await http.get(url, headers: {
      "Authorization": "Token " + token,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Item.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
