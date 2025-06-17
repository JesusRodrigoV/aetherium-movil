import 'dart:convert';

import 'package:aetherium_movil/core/models/note.dart';
import 'package:aetherium_movil/features/notes/providers/controllers_provider.dart';
import 'package:aetherium_movil/features/notes/states/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class NoteNotifier extends StateNotifier<NoteState> {
  final Ref ref;

  NoteNotifier(this.ref)
      : super(NoteState(title: '', content: jsonEncode(Document().toDelta().toJson())));

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateContent(Document document) {
    state = state.copyWith(content: jsonEncode(document.toDelta().toJson()));
  }

  void saveNote(BuildContext context) {
    if (state.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La nota está vacía')),
      );
      return;
    }

    final note = Note(
      title: state.title.isEmpty ? 'Sin título' : state.title,
      content: state.content,
    );

    // TODO: Guardar la nota en la base de datos local (sqflite o hive)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nota guardada (placeholder)')),
    );

    Navigator.pop(context, note);
  }

  void initializeControllers() {
    final controllers = ref.read(controllersProvider);
    controllers.titleController.addListener(() {
      updateTitle(controllers.titleController.text);
    });
    controllers.quillController.addListener(() {
      updateContent(controllers.quillController.document);
    });
  }

  @override
  void dispose() {
    // Los controladores se manejan en controllersProvider
    super.dispose();
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, NoteState>((ref) {
  final notifier = NoteNotifier(ref);
  notifier.initializeControllers();
  return notifier;
});