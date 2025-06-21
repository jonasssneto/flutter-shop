import 'package:flutter/foundation.dart';
import '../../../models/product_model.dart';
import '../../../repositories/product_repository.dart';

class HomeController extends ChangeNotifier {
  final ProductRepository _repo;
  List<ProductModel> products = [];
  bool isLoading = false;
  String? error;

  // Novas propriedades para busca, filtro e ordenação
  String _search = '';
  String? _selectedCategory;
  String _orderBy = 'desc'; // 'desc' ou 'asc'

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

  // Getters e setters para busca, categoria e ordenação
  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  String get orderBy => _orderBy;
  set orderBy(String value) {
    _orderBy = value;
    notifyListeners();
  }

  // Getter para lista filtrada e ordenada
  List<ProductModel> get filteredProducts {
    List<ProductModel> filtered = products.where((p) {
      final matchesSearch = _search.isEmpty ||
          p.title.toLowerCase().contains(_search.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
    if (_orderBy == 'desc') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_orderBy == 'asc') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    }
    return filtered;
  }

  // Getter para categorias únicas
  List<String> get categories =>
      products.map((p) => p.category).toSet().toList();
}
