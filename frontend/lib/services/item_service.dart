import 'dart:convert';
import 'dart:io';

import 'package:frontend/resources/constants.dart';
import "package:http/http.dart" as http;

class ItemService {
  static Future<bool> addItem(String token, String barcode, DateTime expiryDate,
      DateTime purchasedDate) async {
    Uri url = Uri.parse(Constants.addItemUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        },
        body: json.encode({
          "barcode": barcode,
          "expiry_date": expiryDate,
          "purchasedDate": purchasedDate,
        }),
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
}
