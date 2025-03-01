import 'package:bloc_sm/features/access%20controls/domain/entities/access_control.dart';
import 'package:bloc_sm/features/access%20controls/presentation/widgets/my_permission_button.dart';
import 'package:flutter/material.dart';

class PermissionTile extends StatelessWidget {

  final AccessControl accessControl;

  const PermissionTile({
    super.key,
    required this.accessControl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.inversePrimary,
              spreadRadius: -7,
              blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            accessControl.username,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          Text(
            accessControl.permission,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          MyPermissionButton(permissionId: accessControl.id, text: "Delete")
        ],
      ),
    );
  }
}