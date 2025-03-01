import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const MyPasswordField({
    super.key,
    required this.controller,
    required this.hintText
  });

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {

  bool showPassword = false;

  void toggleShowPassowrd() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(

        hintText: widget.hintText,

        suffixIcon: GestureDetector(
          onTap: toggleShowPassowrd,
          child: Icon( showPassword ? Icons.lock : Icons.no_encryption_rounded ),
        ) ,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12)
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12)
        ),

        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true
      ),
    );
  }
}