import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../../features/cart/controllers/cart_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  final CartController _cartController = CartController();

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(product.image, height: 200),
            SizedBox(height: 16),
            Text(product.title,
                style: TextStyle(fontSize: 20, color: AppColors.textPrimary)),
            SizedBox(height: 8),
            Text('R\$ \ ${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: AppColors.primary)),
            SizedBox(height: 16),
            Text(product.description),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _cartController.addProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Adicionado ao carrinho')),
                );
              },
              child: Text('Comprar'),
            ),
          ],
        ),
      ),
    );
  }
}
