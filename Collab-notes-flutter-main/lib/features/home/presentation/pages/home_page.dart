import 'package:bloc_sm/features/home/presentation/widgets/my_drawer.dart';
import 'package:bloc_sm/features/home/presentation/widgets/note_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 15
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NoteCard(
              text: "Your Own Notes",
              route: "/get-own-notes-of-a-user",
              isOwn: true,
              isWritable: true
            ),
            NoteCard(
              text: "Editable Notes",
              route: "/get-editable-notes-of-a-user",
              isOwn: false,
              isWritable: true
            ),
            NoteCard(
              text: "Readable Notes",
              route: "/get-readable-notes-of-a-user",
              isOwn: false,
              isWritable: false
            ),
          ],
        ),
      ),
    );
  }
}