import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/item_model.dart';
import 'package:frontend/services/item_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemViewModel extends ChangeNotifier {
  String? _token;
  String? get token => _token;
  bool _loading = false;
  bool get loading => _loading;

  Item? _item;
  Item? get item => _item;
  Item? get selectedItem => _item;

  List<Item> _itemsList = [];
  List<Item> get itemsList => _itemsList;

  ItemViewModel() {
    getToken().then((token) => {getItems(token)});
  }
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setItem(Item item) {
    _item = item;
  }

  setItemsList(List<Item> itemsList) {
    _itemsList = itemsList;
  }

  Future getToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _token = prefs.getString("token");
    if (_token == null) {
      log("no token");
    }
    log("token :" + _token!);
    notifyListeners();
    return _token;
  }

  Future<void> addItem(String token, Item item) async {
    setLoading(true);
    var response = await ItemService.addItem(token, item);
    if (response) {
      setItem(item);
    }
    setLoading(false);
    notifyListeners();
  }

  setSelectedItem(Item item) {
    _item = item;
  }

  Future<void> getItems(String token) async {
    setLoading(true);
    _itemsList = await ItemService.fetchItems(token);
    if (_itemsList.isNotEmpty) {
      setLoading(false);
    }
    notifyListeners();
  }
}
