import 'package:bloc_sm/features/access%20controls/presentation/cubits/access_control_cubit.dart';
import 'package:bloc_sm/features/auth/presentation/components/my_text_field.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/my_note_option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddPermissionPage extends StatelessWidget {
  final String noteId;
  AddPermissionPage({
    super.key,
    required this.noteId
  });

  void addPermission(String username, String permission, AccessControlCubit accessControlCubit, AuthCubit authCubit) async {
    await accessControlCubit.giveAccessByUsername(username, noteId, permission, authCubit.currentUser!.token);
  }

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Add Permission"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            MyTextField(controller: usernameController, hintText: "Access gainers username"),
            const SizedBox(height: 20,),
            Row(
              children: [
                MyNoteOptionButton(text: "Read", color: Colors.blue, onTap: ()=>addPermission( usernameController.text.trim().toLowerCase(), "read", context.read<AccessControlCubit>(), context.read<AuthCubit>())),
                MyNoteOptionButton(text: "Write", color: Colors.blue, onTap: ()=>addPermission( usernameController.text.trim().toLowerCase(), "write", context.read<AccessControlCubit>(), context.read<AuthCubit>()))
              ],
            )
          ],
        )
      ),
    );
  }
}