import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/pages/product_detail_page.dart';
import '../../../models/product_model.dart';
import '../../../features/cart/controllers/cart_controller.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final CartController cartController;
  const ProductTile({required this.product, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailPage(
              product: product, cartController: cartController),
        ));
      },
      child: Card(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.border),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'R\$ ${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.primary, size: 16),
                  SizedBox(width: 2),
                  Text(product.rating.toStringAsFixed(1),
                      style:
                          TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  SizedBox(width: 8),
                  Text('Estoque: ${product.count}',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
