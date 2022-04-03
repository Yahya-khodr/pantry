import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/user_model.dart';
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

  Future<HTTPResponse<String>> registerUser(
      String name, String email, String password) async {
    Uri url = Uri.parse(Constants.registerUrl);

    try {
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"name": name, "email": email, "password": password}),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return HTTPResponse(true, data['token'], "Registration Successful",
            response.statusCode);
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

  static Future<UserProfile> getUserDetails(String token) async {
    dynamic userData = [];
    Uri url = Uri.parse(Constants.getUserDetailsUrl);

    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token " + token,
      },
    );
    if (response.statusCode == 200) {
      userData = json.decode(response.body);
      User user = User.fromJson(userData['user']);
      Profile profile = Profile.fromJson(userData['profile']);
      return UserProfile(user: user, profile: profile);
    } else {
      return userData;
    }
  }

  static Future<bool> updateProfilePicture(File imageFile, String token) async {
    Uri url = Uri.parse(Constants.updateProfileImageUrl);
    String base64file = base64Encode(imageFile.readAsBytesSync());
    String fileName = imageFile.path.split("/").last;
    Map headerData = {};
    headerData['name'] = fileName;
    headerData['file'] = base64file;

    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token " + token,
      },
      body: json.encode(headerData),
    );

    if (response.statusCode == 200) {
     
      return true;
    } else {
      return false;
    }
  }
}
