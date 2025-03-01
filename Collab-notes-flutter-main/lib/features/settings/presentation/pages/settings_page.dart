import 'package:bloc_sm/themes/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting Page",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Dark Mode",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            CupertinoSwitch(
              value: themeCubit.isDarkMode,
              onChanged: (state) => themeCubit.toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}