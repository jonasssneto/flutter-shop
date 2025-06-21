import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/product_tile.dart';
import '../../cart/controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  final CartController cartController;
  const HomePage({required this.controller, required this.cartController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, __) {
        if (widget.controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (widget.controller.error != null) {
          return Center(child: Text(widget.controller.error!));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: widget.controller.products.length,
            itemBuilder: (_, i) {
              return ProductTile(
                product: widget.controller.products[i],
                cartController: widget.cartController,
              );
            },
          ),
        );
      },
    );
  }
}
