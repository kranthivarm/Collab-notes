import 'package:bloc_sm/features/notes/presentation/cubits/note_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_state.dart';
import 'package:bloc_sm/features/notes/presentation/pages/create_note_page.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {

  final String route;
  final bool isOwn;
  final bool isWritable;
  final String notesType;

  const NotesPage({
    super.key,
    required this.route,
    required this.isOwn,
    required this.isWritable,
    required this.notesType
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notesType),
        centerTitle: true,
        actions: (isOwn)? [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<NoteCubit>(), child: CreateNotePage()))),
                child: const Icon(Icons.note_add),
              ),
              const SizedBox(width: 20,)
            ],
          )
        ]: null,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocConsumer<NoteCubit, NoteState>(
        builder: (context, noteState) {
          if(noteState is NoteInitial || noteState is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(noteState is NotesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: noteState.notes.isNotEmpty
                ? ListView.builder(
                    itemCount: noteState.notes.length,
                    itemBuilder: (context, index) {
                      return NoteTile(
                        note: noteState.notes[index],
                        isOwn: isOwn,
                        isWritable: isWritable,
                      );
                    },
                  )
                : const Center(
                    child: Text("No notes"),
                  ),
            );
          }
          return const Center(
            child: Text("Error loading notes"),
          );
        },
        listener: (context, noteState) {
          if(noteState is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(noteState.message)));
          }
        }
      ),
    );
  }
}