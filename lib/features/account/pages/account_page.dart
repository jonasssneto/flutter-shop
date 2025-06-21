import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';

class AccountPage extends StatelessWidget {
  final AuthController controller;
  const AccountPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.isLoggedIn) {
      return Center(child: Text('Você não está logado'));
    }
    final user = controller.currentUser!;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome: \${user.name}', style: TextStyle(fontSize: 18, color: AppColors.textPrimary)),
          SizedBox(height: 8),
          Text('Email: \${user.email}', style: TextStyle(fontSize: 18, color: AppColors.textPrimary)),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              controller.logout();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deslogado')));
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
