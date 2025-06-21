import 'package:flutter/material.dart';
import '../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';

class LoginRegisterPage extends StatefulWidget {
  final AuthController controller;
  const LoginRegisterPage({required this.controller});

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _name = '', _email = '', _password = '';
  bool _isLoading = false;
  String? _error;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      if (_isLogin) {
        await widget.controller.login(email: _email, password: _password);
      } else {
        await widget.controller
            .register(name: _name, email: _email, password: _password);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sucesso!')));
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (!_isLogin)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: Validators.requiredField,
                  onSaved: (v) => _name = v!.trim(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validators.email,
                onSaved: (v) => _email = v!.trim(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: Validators.password,
                onSaved: (v) => _password = v!.trim(),
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_error!, style: TextStyle(color: Colors.red)),
              ),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(_isLogin ? 'Login' : 'Cadastrar'),
                    ),
                  ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                  _error = null;
                });
              },
              child: Text(_isLogin
                  ? 'Ainda não tem conta? Cadastre-se'
                  : 'Já tem conta? Faça login'),
            ),
          ],
        ),
      ),
    );
  }
}
