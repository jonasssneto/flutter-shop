import 'package:flutter/foundation.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/product_model.dart';

class CartController extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addProduct(ProductModel product) {
    final existing = _items.firstWhere(
      (i) => i.product.id == product.id,
      orElse: () => CartItemModel(product: product, quantity: 0),
    );
    if (existing.quantity == 0) {
      _items.add(CartItemModel(product: product));
    } else {
      existing.quantity++;
    }
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
