import '../../../models/cart_item_model.dart';

class OrderModel {
  final int id;
  final List<CartItemModel> items;
  final DateTime date;
  final double total;

  OrderModel({
    required this.id,
    required this.items,
    required this.date,
    required this.total,
  });
}
