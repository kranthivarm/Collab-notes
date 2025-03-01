import 'package:bloc_sm/features/notes/domain/entities/note.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/pages/view_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final bool isOwn;
  final bool isWritable;
  const NoteTile(
      {super.key,
      required this.note,
      required this.isOwn,
      required this.isWritable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<NoteCubit>(),
                child: ViewNotePage(
                  isOwn: isOwn, isWritable: isWritable, note: note
                )
              )
            )
          );
      },
      child: Container(
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  spreadRadius: -7,
                  blurRadius: 10)
            ]),
        child: Text(
          note.title,
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
