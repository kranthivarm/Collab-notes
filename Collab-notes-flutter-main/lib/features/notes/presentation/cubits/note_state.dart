import 'package:bloc_sm/features/notes/domain/entities/note.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class NoteSaving extends NoteState{}

class NoteSuccess extends NoteState{
  String message;
  NoteSuccess(this.message);
}

class NotesLoaded extends NoteState {
  List<Note> notes;
  NotesLoaded(this.notes);
}

class NotesError extends NoteState {
  String message;
  NotesError(this.message);
}