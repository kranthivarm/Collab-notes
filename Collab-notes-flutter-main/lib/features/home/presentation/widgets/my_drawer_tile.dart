import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {

  final String text;
  final IconData icon;
  final void Function() onTap;

  const MyDrawerTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
      )
    );
  }
}