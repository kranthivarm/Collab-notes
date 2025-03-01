
import 'package:bloc_sm/features/access%20controls/domain/entities/access_control.dart';

abstract class AccessControlRepository {

  Future<AccessControl> giveAccessByUsername(String username, String noteId, String permissison, String token);

  Future<void> deletePermission(String id, String token);

  Future<List<AccessControl>> getAllPermissionsOfaNote(String noteId, String token);

}