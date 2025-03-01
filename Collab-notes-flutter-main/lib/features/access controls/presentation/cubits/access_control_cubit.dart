import 'package:bloc_sm/features/access%20controls/domain/entities/access_control.dart';
import 'package:bloc_sm/features/access%20controls/domain/repositories/access_control_repository.dart';
import 'package:bloc_sm/features/access%20controls/presentation/cubits/access_control_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessControlCubit extends Cubit<AccessControlState> {

  final AccessControlRepository accessControlRepository;
  AccessControlCubit(this.accessControlRepository) : super(AccessControlInitial());

  final List<AccessControl> _permissions = [];

  List<AccessControl> get permissions => _permissions;

  Future<void> getAllPermissionsOfaNote(String noteId, String token) async {
    emit(AccessControlLoading());
    try{
      final List<AccessControl> permissions = await accessControlRepository.getAllPermissionsOfaNote(noteId, token);
      emit(AccessControlLoaded(permissions));
    }
    catch(e) {
      emit(AccessControlError(e.toString()));
    }
  }

  Future<void> giveAccessByUsername(String username, String noteId, String permission, String token) async {
    emit(AccessControlLoading());
    try{
      final AccessControl accessControl = await accessControlRepository.giveAccessByUsername(username, noteId, permission, token);
      _permissions.add(accessControl);
      emit(AccessControlSuccess("Permission added successfully"));
    }
    catch(e) {
      emit(AccessControlError(e.toString()));
    }
    finally {
      emit(AccessControlLoaded(_permissions));
    }
  }

  Future<void> deletePermission(String id, String token) async {
    emit(AccessControlLoading());
    try{
      await accessControlRepository.deletePermission(id, token);
      for(AccessControl permission in _permissions) {
        if(permission.id==id) {
          _permissions.remove(permission);
          break;
        }
      }
      emit(AccessControlSuccess("Permission removed successfully"));
      emit(AccessControlLoaded(_permissions));
    }
    catch(e) {
      emit(AccessControlError(e.toString()));
    }
  }


}