import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/services/api_service.dart';
import 'repositories/product_repository.dart';
import 'features/home/controllers/home_controller.dart';
import 'features/cart/controllers/cart_controller.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/orders/controllers/orders_controller.dart';
import 'shared/widgets/bottom_nav_bar.dart';
import 'features/home/pages/home_page.dart';
import 'features/cart/pages/cart_page.dart';
import 'features/auth/pages/login_register_page.dart';
import 'features/account/pages/account_page.dart';
import 'features/orders/pages/orders_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final apiService = ApiService();
  late final productRepo = ProductRepository(apiService);
  late final homeController = HomeController(productRepo);
  final cartController = CartController();
  final authController = AuthController();
  final ordersController = OrdersController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniShop',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          error: AppColors.destructive,
          onError: AppColors.onDestructive,
          surface: AppColors.card,
          onSurface: AppColors.textPrimary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        cardColor: AppColors.card,
        dividerColor: AppColors.border,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.input,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.ring, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(color: AppColors.textPrimary),
              bodyMedium: TextStyle(color: AppColors.textPrimary),
              bodySmall: TextStyle(color: AppColors.textMuted),
              titleLarge: TextStyle(color: AppColors.textPrimary),
              titleMedium: TextStyle(color: AppColors.textPrimary),
              titleSmall: TextStyle(color: AppColors.textMuted),
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
        ),
        useMaterial3: true,
      ),
      home: MainPage(
        homeController: homeController,
        cartController: cartController,
        authController: authController,
        ordersController: ordersController,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final HomeController homeController;
  final CartController cartController;
  final AuthController authController;
  final OrdersController ordersController;

  const MainPage({
    required this.homeController,
    required this.cartController,
    required this.authController,
    required this.ordersController,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final OrdersController ordersController = OrdersController();

  late final pages = [
    HomePage(
        controller: widget.homeController,
        cartController: widget.cartController),
    CartPage(
        controller: widget.cartController,
        ordersController: widget.ordersController),
    OrdersPage(controller: widget.ordersController),
    AccountPage(controller: widget.authController),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.authController,
      builder: (context, _) {
        if (!widget.authController.isLoggedIn) {
          return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: LoginRegisterPage(controller: widget.authController),
          );
        }
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
          ),
        );
      },
    );
  }
}
