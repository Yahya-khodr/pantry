import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/http_response.dart';

class UserService with ChangeNotifier {
  Future<HTTPResponse<String>> loginUser(String email, String password) async {
    Uri url = Uri.parse(Constants.loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"email": email, "password": password}),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        log("Token " + data['token']);
        return HTTPResponse(
            true, data['token'], "Login Successful", response.statusCode);
      } else {
        log(response.body);
        return HTTPResponse(false, "", data['error'], response.statusCode);
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
