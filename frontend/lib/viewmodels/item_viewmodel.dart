import 'package:flutter/cupertino.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/item_model.dart';
import 'package:frontend/services/item_service.dart';

class ItemViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Item? _item;
  Item? get item => _item;

  Item? get selectedItem => _item;
  List<Item> _itemsList = [];
  List<Item> get itemsList => _itemsList;

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

  getItems(String token) async {
    setLoading(true);
    var response = await ItemService.getItems(token);
    if (response.isSuccessful) {
      setItemsList(response.data as List<Item>);
    }
    setLoading(false);
    notifyListeners();
  }
}
