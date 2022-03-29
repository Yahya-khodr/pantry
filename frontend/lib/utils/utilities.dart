import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class Utilities {
  static fetchAndSaveUserInfo({required String res}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString("token");
    token ??= res; // => if (token == null ) { token = res}

    UserService.getUserDetails(token).then((value) {
      User? _user = value.user;
      Profile? _profile = value.profile;

      prefs.setString("name", _user?.name ?? "");
      prefs.setString("email", _user?.email ?? "");
      prefs.setString("token", _user?.token ?? "");
      prefs.setString("imageUrl", _profile?.imageUrl ?? "");
      prefs.setString("birth_date", (_profile?.birthDate ?? "") as String) ;
      prefs.setInt("weight", _profile?.weight ?? 0);
      prefs.setInt("height", _profile?.height ?? 0);
      prefs.setString("gender", _profile?.gender ?? "");
    });
  }
   static Future<UserProfile> getUserProfile() async {
    UserProfile _userProfile =  UserProfile();

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _userProfile.user?.name = prefs.getString("name") as String;
    _userProfile.user?.email = prefs.getString("email") as String;
    _userProfile.profile?.imageUrl = prefs.getString("imageUrl");
    

    return _userProfile;
  }

  static clearSharedPreferences(BuildContext context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  static showSnackbar(BuildContext context, String message, bool success) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static showAlertDialog(
      BuildContext context, String title, String message, bool success) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if (success) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  static String stringToDateTime(String date) {
    var dateTime = DateTime.parse(date);
    var formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(dateTime);
  }
}
