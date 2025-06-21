import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      backgroundColor: AppColors.background,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'Carrinho'),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long), label: 'Pedidos'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
      ],
    );
  }
}
