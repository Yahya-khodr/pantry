import 'package:flutter/cupertino.dart';
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

  fetchProduct(String barcode) async {
    setLoading(true);
    var response = await _productService.fetchProduct(barcode);
    if (response.isSuccessful) {
      setProduct(response.data.product!);
      setNutriments(response.data.product?.nutriments as Nutriments);
    }
    setLoading(false);
  }
}
