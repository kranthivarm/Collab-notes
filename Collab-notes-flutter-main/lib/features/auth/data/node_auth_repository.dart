import 'dart:convert';

import 'package:bloc_sm/constants/urls.dart';
import 'package:bloc_sm/features/auth/domain/entities/user.dart';
import 'package:bloc_sm/features/auth/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NodeAuthRepository implements AuthRepository {
  @override
  Future<User?> loginUser(String username, String password) async {
    try {

      // making a login request
      final response = await http.post(
          Uri.parse('${Urls.apiBaseUrl}/auth/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": username, "password": password})
        );

      // decoding the response
      final responseBody = jsonDecode(response.body);


      // checking the status
      if (response.statusCode == 200) {


        // creating a new user
        final User user = User(
            id: responseBody['_id'],
            email: responseBody['email'],
            username: responseBody['username'],
            token: responseBody['token'],
          );


        //saving the user locally
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await Future.wait([
          prefs.setString('token', user.token),
          prefs.setString('username', user.username),
          prefs.setString('email', user.email),
          prefs.setString('id', user.id)
        ]);
        
        return user;
      }
      else {
        throw responseBody['message'];
      }
    }
    catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> registerUser(String username, String email, String password) async {
    try {

      // making a register request
      final response = await http.post(
          Uri.parse('${Urls.apiBaseUrl}/auth/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email, "username": username, "password": password})
        );

      // decoding the response
      final responseBody = jsonDecode(response.body);


      // checking the status
      if (response.statusCode == 201) {
        return true;
      }
      else {
        throw responseBody['message'];
      }
    }
    catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {

    // removing the user from local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove('id'),
      prefs.remove('token'),
      prefs.remove('email'),
      prefs.remove('username'),
    ]);


  }

  @override
  Future<User?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token != null) {
      final [ id, email, username ] = [
        prefs.getString('id'),
        prefs.getString('email'),
        prefs.getString('username')
      ];
      return User(id: id!, email: email!, username: username!, token: token);
    }
    return null;
  }
}
