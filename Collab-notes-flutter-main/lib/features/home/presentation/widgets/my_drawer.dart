import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/home/presentation/widgets/my_drawer_tile.dart';
import 'package:bloc_sm/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              MyDrawerTile(
                text: "H O M E",
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              MyDrawerTile(
                text: "P R O F I L E",
                icon: Icons.person,
                onTap: () {},
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              MyDrawerTile(
                text: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SettingsPage()));
                },
              ),
              const Spacer(),
              MyDrawerTile(
                text: "L O G O U T",
                icon: Icons.logout,
                onTap: () async {
                    final authCubit = context.read<AuthCubit>();
                    await authCubit.logout();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logout successful")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}