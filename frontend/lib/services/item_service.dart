import 'dart:convert';
import 'dart:io';

import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/item_model.dart';
import 'package:frontend/resources/constants.dart';
import "package:http/http.dart" as http;

class ItemService {
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

  static Future<HTTPResponse<List<Item>?>> getItems(String token) async {
    Uri url = Uri.parse(Constants.getItemsUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
      );
      if (response.statusCode == 200) {
        return HTTPResponse(true, itemsListModelFromJson(response.body),
            "Success", response.statusCode);
      } else {
        return HTTPResponse(false, jsonDecode(response.body),
            "Failed to get items", response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, null, "No Internet connection", 400);
    } on FormatException {
      return HTTPResponse(false, null, "Invalid Response", 400);
    } catch (e) {
      return HTTPResponse(false, null, "Error occured", 400);
    }
  }
}
