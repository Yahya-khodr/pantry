import 'package:flutter/cupertino.dart';
import 'package:frontend/models/item_model.dart';
import 'package:frontend/services/item_service.dart';

class ItemViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  Item? _item;
  Item? get item => _item;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setItem(Item item) {
    _item = item;
  }

  addItem(String token, Item item) async {
    setLoading(true);
    var response = await ItemService.addItem(token, item);
    if (response) {
      setItem(item);
    }
    setLoading(false);
    notifyListeners();
  }
}
