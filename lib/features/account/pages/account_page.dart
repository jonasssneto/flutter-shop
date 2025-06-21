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
    return Center(
      child: Card(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 64, color: AppColors.primary),
              SizedBox(height: 16),
              Text(user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  )),
              SizedBox(height: 8),
              Text(user.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  )),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.logout();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Deslogado')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.destructive,
                    foregroundColor: AppColors.onDestructive,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
