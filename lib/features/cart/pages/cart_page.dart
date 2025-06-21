import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  final CartController controller;
  const CartPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.items.isEmpty) {
          return Center(child: Text('Carrinho vazio'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (_, i) {
                  final item = controller.items[i];
                  return CartItemTile(
                    item: item,
                    onRemove: () => controller.decreaseProduct(item.product.id),
                    onAdd: () => controller.addProduct(item.product),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.textPrimary)),
                  Text('R\$ ${controller.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, color: AppColors.primary)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
