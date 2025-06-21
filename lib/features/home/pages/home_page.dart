import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({required this.controller});

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
        return ListView.builder(
          itemCount: widget.controller.products.length,
          itemBuilder: (_, i) {
            return ProductTile(product: widget.controller.products[i]);
          },
        );
      },
    );
  }
}
