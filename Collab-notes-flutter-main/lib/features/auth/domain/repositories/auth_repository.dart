import 'package:bloc_sm/features/auth/domain/entities/user.dart';

abstract class AuthRepository {


  Future<User?> loginUser(String username, String password);
  
  Future<bool> registerUser(String username, String email, String password);
  
  Future<void> logout();

  Future<User?> getCurrentUser();


}