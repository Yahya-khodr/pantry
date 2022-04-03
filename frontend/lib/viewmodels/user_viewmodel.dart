import 'package:flutter/cupertino.dart';
import 'package:frontend/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { authenticated, authenticating, unauthenticated }

class UserViewModel extends ChangeNotifier {
  Status get status => _status;
  Status _status = Status.unauthenticated;
  User user = User();

  String? _token;
  String? get token => _token;
  String? name;
  String? email;
  String? password;
  bool _loading = false;
  bool get loading => _loading;

  UserViewModel() {
    getUserToken();
  }
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setToken(String token) async {
    _token = token;
  }

  setUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString("name", user.name ?? "");
    await sharedPreferences.setString("token", user.token ?? "");

    await sharedPreferences.setString("email", user.email ?? "");

    notifyListeners();
  }

  Future<String?> getUserToken() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setToken(prefs.getString("token") ?? "");
    setLoading(false);
    notifyListeners();
    return token;
  }



  deleteUserToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    _status = Status.unauthenticated;
    notifyListeners();
  }

  Future<void> signOut() async {
    setLoading(true);
    deleteUserToken();

    notifyListeners();
    setLoading(false);
    return Future.delayed(Duration.zero); // need for type return
  }
}
