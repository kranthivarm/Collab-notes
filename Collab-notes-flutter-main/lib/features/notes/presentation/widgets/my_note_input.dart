import 'package:flutter/material.dart';

class MyNoteInput extends StatelessWidget {

  final int maxLines;
  final TextEditingController controller;
  final String hintText;
  final bool isWritable;

  const MyNoteInput({
    super.key,
    required this.maxLines,
    required this.controller,
    required this.hintText,
    required this.isWritable
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      readOnly: !isWritable,
      decoration: InputDecoration(

        hintText: hintText,

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