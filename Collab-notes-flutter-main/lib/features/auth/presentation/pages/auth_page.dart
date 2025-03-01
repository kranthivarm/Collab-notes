import 'package:bloc_sm/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_sm/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void toggleShowLoginPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage ? LoginPage( togglePages: toggleShowLoginPage ) : RegisterPage( togglePages: toggleShowLoginPage );
  }
}