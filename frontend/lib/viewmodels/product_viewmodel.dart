import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/nutriment_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  Product? _product;
  Product? get product => _product;

  String? _imageUrl;
  String? get getImage => _imageUrl;
  Nutriments? _nutriments;
  Nutriments? get nutriments => _nutriments;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setNutriments(Nutriments nutriments) {
    _nutriments = nutriments;
  }

  setProduct(Product product) {
    _product = product;
  }

  setImage(String image) {
    _imageUrl = image;
  }

  // for remote api (for the scan)
  fetchProduct(String barcode) async {
    setLoading(true);
    var response = await _productService.fetchProduct(barcode);
    if (response.isSuccessful) {
      setProduct(response.data.product!);
      setImage(response.data.product?.imageUrl ?? "");
      // setNutriments(response.data.product?.nutriments as Nutriments);
    }
    setLoading(false);
    notifyListeners();
  }

  // for local api (local database)
  Future<bool> addProduct(
      String token, barcode, productName, qty, category, imageUrl) async {
    setLoading(true);
    var resposne = await _productService.addProduct(
        token, barcode, productName, qty, category, imageUrl);
    if (resposne.isSuccessful) {
      return true;
    } else {
      return false;
    }
  }

  Future<Product?> getProduct(String barcode) async {
    setLoading(true);
    final response = await _productService.getProduct(barcode);
    if (response.isSuccessful) {
      log(response.message);
      return response.data;
    }
    setLoading(false);
    log(response.message);
    notifyListeners();
    return null;
  }
}
