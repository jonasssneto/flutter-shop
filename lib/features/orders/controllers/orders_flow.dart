import 'package:flutter/material.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/orders_controller.dart';

class OrdersFlow {
  final CartController cartController;
  final OrdersController ordersController;

  OrdersFlow({required this.cartController, required this.ordersController});

  void finalizeOrder() {
    if (cartController.items.isEmpty) return;
    ordersController.addOrder(cartController.items, cartController.totalAmount);
    cartController.clear();
  }
}
