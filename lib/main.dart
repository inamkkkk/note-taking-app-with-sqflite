import 'package:flutter/material.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:note_app/services/note_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => NoteProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteListScreen(),
    );
  }
}