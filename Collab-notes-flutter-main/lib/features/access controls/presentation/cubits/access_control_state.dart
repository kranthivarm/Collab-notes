import 'package:bloc_sm/features/access%20controls/domain/entities/access_control.dart';

abstract class AccessControlState {}

class AccessControlInitial extends AccessControlState {}

class AccessControlLoading extends AccessControlState {}

class AccessControlLoaded extends AccessControlState {
  List<AccessControl> permissions;
  AccessControlLoaded(this.permissions);
}


class AccessControlSuccess extends AccessControlState {
  String message;
  AccessControlSuccess(this.message);
}

class AccessControlError extends AccessControlState {
  String message;
  AccessControlError(this.message);
}