import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  static fetchAndSaveUserInfo({required String res}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString("token");
    token ??= res; // => if (token == null ) { token = res}
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
}