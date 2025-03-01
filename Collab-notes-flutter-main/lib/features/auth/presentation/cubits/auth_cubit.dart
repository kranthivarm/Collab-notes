import 'dart:async';

import 'package:bloc_sm/features/auth/domain/entities/user.dart';
import 'package:bloc_sm/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthRepository authRepository;

  User? _currentUser;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void checkAuth() async {
    final User? user = await authRepository.getCurrentUser();

    if(user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    }
    else {
      emit(Unauthenticated());
    }
  }

  User? get currentUser => _currentUser;

  Future<void> login(String usernameOrEmail, String password) async {
    try{
      emit(AuthLoading());
      final User? user = await authRepository.loginUser(usernameOrEmail, password);

      if(user != null) {
        _currentUser = user;
        emit(AuthSuccess("Login successful"));
        emit(Authenticated(user));
      }
      else {
        emit(Unauthenticated());
      }
    }
    catch(e) {
      emit(Unauthenticated());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String username, String email, String password) async {
    try{
      emit(AuthLoading());
      bool isUserCreated = await authRepository.registerUser(username, email, password);
      if(isUserCreated) {
        await login(username, password);
      }
    }
    catch(e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> logout() async {
    await authRepository.logout();
    emit(Unauthenticated());
  }


}