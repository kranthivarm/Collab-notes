import 'package:bloc_sm/features/auth/presentation/components/my_button.dart';
import 'package:bloc_sm/features/auth/presentation/components/my_password_field.dart';
import 'package:bloc_sm/features/auth/presentation/components/my_text_field.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  final void Function()? togglePages;

  LoginPage({
    super.key,
    required this.togglePages
  });

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    final username = _usernameController.text.trim().toLowerCase();
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
    }
    else {
      final authCubit = context.read<AuthCubit>();
      await authCubit.login(username, password);
      if(authCubit.currentUser != null) {
        // display login successful
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              
                  const SizedBox(height: 50,),
              
                  Text(
                    "Welcome back, you've been missed",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16
                    ),
                  ),
              
                  const SizedBox(height: 25,),
              
              
                  MyTextField(controller: _usernameController, hintText: "Email or username"),
              
                  const SizedBox(height: 10,),
                  MyPasswordField(controller: _passwordController, hintText: "Enter your password"),
              
                  const SizedBox(height: 10,),
                  MyButton(
                    onTap: () => login(context),
                    text: "Login",
                  ),
              
                  const SizedBox(height: 25,),  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16
                          ),
                        ),
                      GestureDetector(
                        onTap: togglePages,
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}