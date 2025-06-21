import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_tile.dart';
import '../../orders/controllers/orders_controller.dart';

class CartPage extends StatelessWidget {
  final CartController controller;
  final OrdersController ordersController;
  const CartPage(
      {required this.controller, required this.ordersController, Key? key})
      : super(key: key);

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
              child: Container(
                color: AppColors.input.withOpacity(0.18),
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (_, i) {
                    final item = controller.items[i];
                    return CartItemTile(
                      item: item,
                      onRemove: () =>
                          controller.decreaseProduct(item.product.id),
                      onAdd: () => controller.addProduct(item.product),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: AppColors.primary.withOpacity(0.08),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total:',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.textPrimary)),
                          Text(
                              'R\$ ${controller.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary)),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ordersController.addOrder(
                              controller.items, controller.totalAmount);
                          controller.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Pedido realizado com sucesso!')),
                          );
                        },
                        icon: Icon(Icons.shopping_cart_checkout,
                            color: AppColors.onPrimary),
                        label: Text('Finalizar',
                            style: TextStyle(color: AppColors.onPrimary)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
