import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/models/nutriment_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  Product? _product;
  Product? get product => _product;

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

  // for remote api (for the scan)
  fetchProduct(String barcode) async {
    setLoading(true);
    var response = await _productService.fetchProduct(barcode);
    if (response.isSuccessful) {
      setProduct(response.data.product!);
      setNutriments(response.data.product?.nutriments as Nutriments);
    }
    setLoading(false);
    notifyListeners();
  }

  // for local api (local database)
  addProduct(String token, Product product) async {
    setLoading(true);
    var resposne = await _productService.addProduct(token, product);
    if (resposne.isSuccessful) {
      setProduct(product);
      return HTTPResponse(
          true, resposne.data, "Success", resposne.responseCode);
    }
    setLoading(false);
    notifyListeners();
  }

  getProduct(String barcode) async {
    setLoading(true);
    var response = await _productService.getProduct(barcode);
    if (response.isSuccessful) {
      setProduct(response.data!);
     
    }
    setLoading(false);
    notifyListeners();
  }
}
