import 'package:bloc_sm/features/access%20controls/presentation/pages/access_controls_page.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/notes/domain/entities/note.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_state.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/my_note_input.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/my_note_option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewNotePage extends StatelessWidget {
  final bool isOwn;
  final bool isWritable;
  final Note note;

  ViewNotePage({
    super.key,
    required this.isOwn,
    required this.isWritable,
    required this.note,
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void updateNote(NoteCubit noteCubit, AuthCubit authCubit) async {
    final String title = _titleController.text;
    final String content = _contentController.text;
    if (title.trim().isNotEmpty && content.trim().isNotEmpty) {
      await noteCubit.updateNote(
          Note(content: content, title: title, noteId: note.noteId),
          authCubit.currentUser!.token);
    } else {
      print("Can't be empty");
    }
  }

  Future<void> deleteNote(NoteCubit noteCubit, AuthCubit authCubit) async {
    await noteCubit.deleteNote(note.noteId, authCubit.currentUser!.token);
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = note.title;
    _contentController.text = note.content;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Note'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: (isOwn)
            ? [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AccessControlsPage(noteId: note.noteId,))),
                  child: const Icon(Icons.group),
                ),
                const SizedBox(width: 20)
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<NoteCubit, NoteState>(
          builder: (context, noteState) {
            if (noteState is NotesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                MyNoteInput(
                    maxLines: 5,
                    controller: _titleController,
                    hintText: "Note title",
                    isWritable: isWritable),
                const SizedBox(height: 20),
                MyNoteInput(
                    maxLines: 20,
                    controller: _contentController,
                    hintText: "Note content",
                    isWritable: isWritable),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (isWritable)
                        ? MyNoteOptionButton(
                            text: "Save Note",
                            color: Colors.green,
                            onTap: () {
                              updateNote(context.read<NoteCubit>(),
                                  context.read<AuthCubit>());
                            })
                        : const Text(""),
                    (isOwn)
                        ? MyNoteOptionButton(
                            text: "Delete Note",
                            color: Colors.red,
                            onTap: () async {
                              await deleteNote(context.read<NoteCubit>(),
                                  context.read<AuthCubit>());
                              Navigator.pop(context);
                            },
                          )
                        : const Text(""),
                  ],
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is NotesError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
