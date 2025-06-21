import 'package:flutter/foundation.dart';
import '../../../models/product_model.dart';
import '../../../repositories/product_repository.dart';

class HomeController extends ChangeNotifier {
  final ProductRepository _repo;
  List<ProductModel> products = [];
  bool isLoading = false;
  String? error;

  HomeController(this._repo);

  Future<void> loadProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await _repo.fetchAll();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
