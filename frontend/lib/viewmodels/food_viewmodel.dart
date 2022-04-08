import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/services/food_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  String? _token;
  String? get token => _token;

  Food _selectedFood = Food();
  Food get selectedFood => _selectedFood;

  List<Food> _foodList = [];
  List<Food> get foodList => _foodList;
  List<Food> _foodListByCategory = [];
  List<Food> get foodListByCategory => _foodListByCategory;


  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  setFoodList(List<Food> foodList) {
    _foodList = foodList;
  }

  setFoodListByCategory(List<Food> foodListByCategory, String category) {
    _foodListByCategory = foodListByCategory;
  }

  setFood(Food food) {
    _foodList.add(food);
  }

  setToken(String? token) async {
    _token = token;
  }

  setSelectedFood(Food food) {
    _selectedFood = food;
  }

  Future<String?> getUserToken() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setToken(prefs.getString("token"));
    setLoading(false);
    notifyListeners();
    return _token;
  }

  getFoods(String token) async {
    setLoading(true);
    _foodList = await FoodService.getFoods(token);
    setLoading(false);
    notifyListeners();
  }

  Future<void> getFoodsByCategory(String token, String category) async {
    setLoading(true);
    _foodListByCategory = await FoodService.getFoodsByCategory(token, category);
    setLoading(false);
    notifyListeners();
  }

  Future<bool> addFood(String token, String barcode, String name, String qty,
      String expDate, String purDate, String category, File imageFile) async {
    setLoading(true);
    var response = await FoodService.addFood(
        token, barcode, expDate, purDate, name, qty, category, imageFile);
    if (response) {
      setLoading(false);
      return true;
    }
    setLoading(false);
    notifyListeners();
    return false;
  }
}
