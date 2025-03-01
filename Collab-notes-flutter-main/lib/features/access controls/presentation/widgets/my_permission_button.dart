import 'package:bloc_sm/features/access%20controls/presentation/cubits/access_control_cubit.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPermissionButton extends StatelessWidget {

  final String permissionId;
  final String text;

  const MyPermissionButton({
    super.key,
    required this.permissionId,
    required this.text
  });

  void onTap(AuthCubit authCubit, AccessControlCubit accessControlCubit) async {
    final String token = authCubit.currentUser!.token;
    await accessControlCubit.deletePermission(permissionId, token);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(context.read<AuthCubit>(), context.read<AccessControlCubit>()),
      child: Container(
        width: 100,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.red
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}