import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/product_tile.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../../models/product_model.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  final CartController cartController;
  const HomePage({required this.controller, required this.cartController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _orderBy = 'desc';
  String _search = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    widget.controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredProducts = widget.controller.products;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bem-vindo à UniShop!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  )),
              SizedBox(height: 4),
              Text('Encontre os melhores produtos para você',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  )),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar produto...',
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.primary),
                        filled: true,
                        fillColor: AppColors.input,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    icon: Icon(Icons.filter_alt, color: AppColors.primary),
                    onPressed: () async {
                      final result = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) {
                          String? selectedOrder = _orderBy;
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Ordenar por',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                RadioListTile<String>(
                                  title: Text('Maior preço'),
                                  value: 'desc',
                                  groupValue: selectedOrder,
                                  onChanged: (v) {
                                    selectedOrder = v;
                                    Navigator.pop(context, v);
                                  },
                                ),
                                RadioListTile<String>(
                                  title: Text('Menor preço'),
                                  value: 'asc',
                                  groupValue: selectedOrder,
                                  onChanged: (v) {
                                    selectedOrder = v;
                                    Navigator.pop(context, v);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          _orderBy = result;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Filtro por categoria
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChoiceChip(
                      label: Text('Todas'),
                      selected: _selectedCategory == null,
                      onSelected: (_) {
                        setState(() => _selectedCategory = null);
                      },
                    ),
                    ...widget.controller.products
                        .map((p) => p.category)
                        .toSet()
                        .map((cat) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ChoiceChip(
                                label: Text(cat),
                                selected: _selectedCategory == cat,
                                onSelected: (_) {
                                  setState(() => _selectedCategory = cat);
                                },
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (_, __) {
              if (widget.controller.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (widget.controller.error != null) {
                return Center(child: Text(widget.controller.error!));
              }
              // Filtro de busca e categoria
              filteredProducts = widget.controller.products.where((p) {
                final matchesSearch = _search.isEmpty ||
                    p.title.toLowerCase().contains(_search.toLowerCase());
                final matchesCategory = _selectedCategory == null ||
                    p.category == _selectedCategory;
                return matchesSearch && matchesCategory;
              }).toList();
              // Ordenação por preço
              if (_orderBy == 'desc') {
                filteredProducts.sort((a, b) => b.price.compareTo(a.price));
              } else if (_orderBy == 'asc') {
                filteredProducts.sort((a, b) => a.price.compareTo(b.price));
              }
              if (filteredProducts.isEmpty) {
                return Center(child: Text('Nenhum produto encontrado.'));
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, i) {
                    return ProductTile(
                      product: filteredProducts[i],
                      cartController: widget.cartController,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
