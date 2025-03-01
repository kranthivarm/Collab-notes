import 'package:bloc_sm/features/notes/domain/entities/note.dart';

abstract class NoteRepository {

  Future<List<Note>> getAllNotesOfaUserBasedonRoute( String route, String token );

  Future<Note> createNote( String title, String content, String token );

  Future<Note> updateNote( Note note, String token);

  Future<void> deleteNote( String noteId, String token);
  

}