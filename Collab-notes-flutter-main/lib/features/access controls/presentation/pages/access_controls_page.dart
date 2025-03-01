import 'package:bloc_sm/features/access%20controls/data/node_access_control_repository.dart';
import 'package:bloc_sm/features/access%20controls/domain/repositories/access_control_repository.dart';
import 'package:bloc_sm/features/access%20controls/presentation/cubits/access_control_cubit.dart';
import 'package:bloc_sm/features/access%20controls/presentation/cubits/access_control_state.dart';
import 'package:bloc_sm/features/access%20controls/presentation/pages/add_permission_page.dart';
import 'package:bloc_sm/features/access%20controls/presentation/widgets/permission_tile.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessControlsPage extends StatelessWidget {
  final String noteId;

  AccessControlsPage({
    super.key,
    required this.noteId,
  });

  final AccessControlRepository accessControlRepository = NodeAccessControlRepository();



  @override
  Widget build(BuildContext context) {
  
      final AccessControlCubit accessControlCubitInstance = AccessControlCubit(accessControlRepository)
        ..getAllPermissionsOfaNote(
          noteId,
          context.read<AuthCubit>().currentUser!.token,
        );

    return BlocProvider.value(
      value: accessControlCubitInstance,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Manage Permissions"),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(value: accessControlCubitInstance, child: AddPermissionPage(noteId: noteId))));
                  },
                  child: const Icon(Icons.add_circle_outline_outlined),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
        body: BlocConsumer<AccessControlCubit, AccessControlState>(
          builder: (context, accessControlState) {
            if (accessControlState is AccessControlLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: (accessControlState.permissions.isNotEmpty)
                    ? ListView.builder(
                        itemCount: accessControlState.permissions.length,
                        itemBuilder: (context, index) {
                          return PermissionTile(
                            accessControl: accessControlState.permissions[index],
                          );
                        },
                      )
                    : const Center(
                        child: Text("No permissions given"),
                      ),
              );
            } else if (accessControlState is AccessControlError) {
              return const Center(
                child: Text("Error loading permissions"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (context, accessControlState) {
            if (accessControlState is AccessControlError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(accessControlState.message)),
              );
            } else if (accessControlState is AccessControlSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(accessControlState.message)),
              );
            }
          },
        ),
      ),
    );
  }
}
