import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_state.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/my_note_input.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/my_note_option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNotePage extends StatelessWidget {
  CreateNotePage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> saveNote(NoteCubit noteCubit, AuthCubit authCubit) async {
    final title = _titleController.text;
    final content = _contentController.text;
    if(title.trim().isNotEmpty && content.trim().isNotEmpty) {
      await noteCubit.createNote(title, content, authCubit.currentUser!.token);
    }
    else {
      print("Title, content can't be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<NoteCubit, NoteState>(
          builder: (context, noteState) {
            if(noteState is NoteSaving) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                MyNoteInput(
                    maxLines: 5,
                    controller: _titleController,
                    hintText: "Note Title",
                    isWritable: true),
                const SizedBox(
                  height: 10,
                ),
                MyNoteInput(
                    maxLines: 20,
                    controller: _contentController,
                    hintText: "Note Content",
                    isWritable: true),
                const SizedBox(
                  height: 10,
                ),
                MyNoteOptionButton(
                    text: "Save Note",
                    color: Colors.green,
                    onTap: () async {
                      await saveNote(context.read<NoteCubit>(), context.read<AuthCubit>());
                      Navigator.pop(context);
                    })
              ],
            );
          },
          listener: (context, noteState) {
            if (noteState is NotesError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(noteState.message)));
            }
            else if (noteState is NoteSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(noteState.message)));
            }
          },
        ),
      ),
    );
  }
}
