import 'dart:convert';

import 'package:bloc_sm/constants/urls.dart';
import 'package:bloc_sm/features/notes/domain/entities/note.dart';
import 'package:bloc_sm/features/notes/domain/repositories/note_repository.dart';
import 'package:bloc_sm/utils/internet_connection_error.dart';
import 'package:http/http.dart' as http;

class NodeNoteRepository extends NoteRepository {

  @override
  Future<List<Note>> getAllNotesOfaUserBasedonRoute(String route, String token) async {
    try {
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}$route"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "token": token
        })
      );

      final decodedResponse = jsonDecode(response.body);

      if(response.statusCode == 200) {
        List<Note> notes = [];
        for (var note in decodedResponse) {
          notes.add(
            Note(
              title: note['noteId']['title'],
              content: note['noteId']['content'],
              noteId: note['noteId']['_id'],
            )
          );
        }
        return notes;
      }
      else {
        throw decodedResponse['message'];
      }
    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }


  @override
  Future<Note> createNote(String title, String content, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/create-note"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": title,
          "content": content,
          "token": token
        })
      );

      final decodedRespose = jsonDecode(response.body);

      if(response.statusCode == 201) {
        return Note(
          title: decodedRespose['note']['title'],
          content: decodedRespose['note']['content'],
          noteId: decodedRespose['note']['_id']
        );
      }
      else {
        throw decodedRespose.message;
      }

    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }

  @override
  Future<Note> updateNote(Note note, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/update-note"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "noteId": note.noteId,
          "title": note.title,
          "content": note.content,
          "token": token
        })
      );

      final decodedRespose = jsonDecode(response.body);

      if(response.statusCode == 200) {
        return Note(
          title: decodedRespose['updatedNote']['title'],
          content: decodedRespose['updatedNote']['content'],
          noteId: decodedRespose['updatedNote']['_id']
        );
      }
      else {
        throw decodedRespose.message;
      }

    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }

  @override
  Future<void> deleteNote(String noteId, String token) async {
    try{
      final response = await http.post(
        Uri.parse("${Urls.apiBaseUrl}/delete-note"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "noteId": noteId,
          "token": token
        })
      );

      final decodedRespose = jsonDecode(response.body);

      if(response.statusCode != 200) {
        throw decodedRespose.message;
      }
    }
    catch(e) {
      throw checkInternetConnectionError(e);
    }
  }


}