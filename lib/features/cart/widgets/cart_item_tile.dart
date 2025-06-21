import 'package:flutter/material.dart';
import '../../../models/cart_item_model.dart';
import '../../../core/constants/app_colors.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  const CartItemTile(
      {required this.item, required this.onRemove, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item.product.image, width: 50, height: 50),
      title: Text(item.product.title,
          style: TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(
        '${item.quantity} x R\$ ${item.product.price} = R\$ ${item.totalPrice}',
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: AppColors.primary),
            onPressed: onRemove,
          ),
          Text(
            '${item.quantity}',
            style: TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.add, color: AppColors.primary),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
