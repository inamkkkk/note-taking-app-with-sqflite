import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/note_provider.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Create Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final title = _titleController.text;
              final content = _contentController.text;

              if (title.isNotEmpty && content.isNotEmpty) {
                if (widget.note == null) {
                  // Create new note
                  final newNote = Note(
                    title: title,
                    content: content,
                  );
                  Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
                } else {
                  // Update existing note
                  final updatedNote = Note(
                    id: widget.note!.id,
                    title: title,
                    content: content,
                  );
                  Provider.of<NoteProvider>(context, listen: false).updateNote(updatedNote);
                }

                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Title and content cannot be empty.')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}