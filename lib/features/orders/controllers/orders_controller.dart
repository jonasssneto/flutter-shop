import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../../../models/cart_item_model.dart';

class OrdersController extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  int _nextId = 1;

  List<OrderModel> get orders => List.unmodifiable(_orders);

  void addOrder(List<CartItemModel> items, double total) {
    _orders.insert(
      0,
      OrderModel(
        id: _nextId++,
        items: List<CartItemModel>.from(items),
        date: DateTime.now(),
        total: total,
      ),
    );
    notifyListeners();
  }
}
