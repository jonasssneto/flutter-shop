import 'package:flutter/material.dart';
import '../../../models/cart_item_model.dart';
import '../../../core/constants/app_colors.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  const CartItemTile({required this.item, required this.onRemove});

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
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onRemove,
      ),
    );
  }
}
