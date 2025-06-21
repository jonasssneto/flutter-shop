import 'package:flutter/foundation.dart';
import '../../../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final List<UserModel> _users = [];
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> login({required String email, required String password}) async {
    final user = _users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception('Credenciais inválidas'),
    );
    _currentUser = user;
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final exists = _users.any((u) => u.email == email);
    if (exists) {
      throw Exception('Email já cadastrado');
    }
    final newUser = UserModel(name: name, email: email, password: password);
    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
