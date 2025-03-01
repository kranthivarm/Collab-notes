import 'package:bloc_sm/features/auth/presentation/components/my_button.dart';
import 'package:bloc_sm/features/auth/presentation/components/my_password_field.dart';
import 'package:bloc_sm/features/auth/presentation/components/my_text_field.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/utils/mail_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {

  final void Function()? togglePages;

  RegisterPage({
    super.key,
    required this.togglePages
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void register(BuildContext context) async {

    final email = _emailController.text.trim().toLowerCase();
    final username = _usernameController.text.trim().toLowerCase();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;


    if(email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
    }
    else if(!validateMail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid mail address")));
    }
    else if(password!=confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Both passwords must match")));
    }
    else{
      final authCubit = context.read<AuthCubit>();
      await authCubit.register(username, email, password);
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
              
              
                  MyTextField(controller: _emailController, hintText: "Enter your E-Mail"),
              
                  const SizedBox(height: 10,),
                  MyTextField(controller: _usernameController, hintText: "Enter your preferred username",),
              
                  const SizedBox(height: 10,),
                  MyPasswordField(controller: _passwordController, hintText: "Enter your password"),
              
                  const SizedBox(height: 10,),
                  MyPasswordField(controller: _confirmPasswordController, hintText: "Confirm your password"),
              
                  const SizedBox(height: 10,),
                  MyButton(
                    onTap: () => register(context),
                    text: "Register",
                  ),
              
                  const SizedBox(height: 25),  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16
                          ),
                        ),
                      GestureDetector(
                        onTap: togglePages,
                        child: Text(
                          "Login",
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