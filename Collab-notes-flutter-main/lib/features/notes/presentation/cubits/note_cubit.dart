import 'package:bloc_sm/features/notes/domain/entities/note.dart';
import 'package:bloc_sm/features/notes/domain/repositories/note_repository.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState> {

  List<Note> _notes = [];

  final NoteRepository noteRepository;

  List? get notes => _notes;

  NoteCubit(this.noteRepository) : super(NoteInitial());

  Future<void> getAllNotesOfaUserBasedonRoute( String route, String token) async {
    
    emit(NotesLoading());
    try{
      _notes = await noteRepository.getAllNotesOfaUserBasedonRoute(route, token);
      emit(NotesLoaded(_notes));
    }
    catch(e) {
      emit(NotesError(e.toString()));
    }
  }


  Future<void> createNote(String title, String content, String token) async {
    emit(NoteSaving());
    try{
      final createdNote = await noteRepository.createNote(title, content, token);
      _notes.add(createdNote);
      emit(NoteSuccess("Note created successfully"));
      emit(NotesLoaded(_notes));
    }
    catch(e) {
      emit(NotesError(e.toString()));
    }
  }


  Future<void> updateNote(Note note, String token) async {
    emit(NotesLoading());
    try{
      final updatedNote = await noteRepository.updateNote(note, token);
      for(int i=0;i<_notes.length;i++) {
        if(_notes[i].noteId == note.noteId) {
          _notes[i] = updatedNote;
        }
      }
      emit(NoteSuccess("Note updated successfully"));
      emit(NotesLoaded(_notes));
    }
    catch(e) {
      emit(NotesError(e.toString()));
    }
  }


  Future<void> deleteNote( String noteId, String token ) async {
    emit(NotesLoading());
    try{
      await noteRepository.deleteNote(noteId, token);
      for(Note note in _notes) {
        if(note.noteId == noteId) {
          _notes.remove(note);
          break;
        }
      }
      emit(NoteSuccess("Note deleted successfully"));
      emit(NotesLoaded(_notes));
    }
    catch(e) {
      emit(NotesError(e.toString()));
    }
  }


}