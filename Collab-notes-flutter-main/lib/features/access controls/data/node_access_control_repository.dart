
import 'dart:convert';

import 'package:bloc_sm/constants/urls.dart';
import 'package:bloc_sm/features/access%20controls/domain/entities/access_control.dart';
import 'package:bloc_sm/features/access%20controls/domain/repositories/access_control_repository.dart';
import 'package:bloc_sm/utils/internet_connection_error.dart';
import 'package:http/http.dart' as http;

class NodeAccessControlRepository extends AccessControlRepository {


  @override
  Future<AccessControl> giveAccessByUsername(String username, String noteId, String permissison, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/give-access-by-username"),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "noteId": noteId,
          "username": username,
          "access": permissison,
          "token": token
        })
      );
      final decodedResponse = jsonDecode(response.body);
      if(response.statusCode == 201) {
        return AccessControl(
          id: decodedResponse['accessControl']['_id'],
          permission: permissison,
          username: username
        );
      }
      throw decodedResponse['message'];
    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }


  @override
  Future<void> deletePermission(String id, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/delete-permission"),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "_id": id,
          "token": token
        })
      );
      final decodedResponse = jsonDecode(response.body);
      if(response.statusCode == 200) {
        return;
      }
      throw decodedResponse['message'];
    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }


  @override
  Future<List<AccessControl>> getAllPermissionsOfaNote(String noteId, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/get-permissions-of-a-note"),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "noteId": noteId,
          "token": token
        })
      );

      final decodedResponse = jsonDecode(response.body);
      List<AccessControl> permissions = [];
      if(response.statusCode == 200) {
        for(int i=0;i<decodedResponse.length;i++) {
          permissions.add(
            AccessControl(
              id: decodedResponse[i]['_id'],
              permission: decodedResponse[i]['permission'],
              username: decodedResponse[i]['userId']['username']
            )
          );
        }
        return permissions;
      }
      throw decodedResponse['message'];
    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }

}