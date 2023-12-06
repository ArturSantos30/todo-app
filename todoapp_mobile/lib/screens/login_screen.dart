import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../services/login_http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = LoginController(LoginHTTP());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    _loginController
                        .login(
                            username: _usernameController.text,
                            password: _passwordController.text)
                        .then((value) {
                      if (value) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Something went wrong')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Create new account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
