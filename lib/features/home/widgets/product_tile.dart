import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/pages/product_detail_page.dart';
import '../../../models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.image, width: 50, height: 50),
      title:
          Text(product.title, style: TextStyle(color: AppColors.textPrimary)),
      subtitle: Text('R\$r ${product.price.toStringAsFixed(2)}',
          style: TextStyle(color: AppColors.textPrimary)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product),
        ));
      },
    );
  }
}
