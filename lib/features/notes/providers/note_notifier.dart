import 'dart:convert';
import 'package:aetherium_movil/core/models/note.dart';
import 'package:aetherium_movil/core/providers/list_notes_provider.dart';
import 'package:aetherium_movil/features/notes/data/note_repository.dart';
import 'package:aetherium_movil/features/notes/providers/controllers_provider.dart';
import 'package:aetherium_movil/features/notes/states/note_state.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_notifier.g.dart';

@riverpod
class NoteNotifier extends _$NoteNotifier {
  @override
  NoteState build({Note? note}) {
    return NoteState.fromNote(note);
  }

  void initializeControllers(NoteControllers controllers) {
    // Limpiar listeners antiguos primero
    controllers.titleController.removeListener(_updateTitleListener);
    controllers.quillController.removeListener(_updateContentListener);

    // Configurar estado inicial
    controllers.titleController.text = state.title;
    if (state.content.isNotEmpty) {
      try {
        controllers.quillController.document = Document.fromJson(
          jsonDecode(state.content),
        );
      } catch (_) {
        controllers.quillController.document = Document();
      }
    }

    // Añadir nuevos listeners
    controllers.titleController.addListener(_updateTitleListener);
    controllers.quillController.addListener(_updateContentListener);

    // Limpiar al destruir
    ref.onDispose(() {
      controllers.titleController.removeListener(_updateTitleListener);
      controllers.quillController.removeListener(_updateContentListener);
    });
  }

  void _updateTitleListener() {
    if (!ref.mounted) return; // ¡Importante!
    final controllers = ref.read(controllersProvider);
    updateTitle(controllers.titleController.text);
  }

  void _updateContentListener() {
    if (!ref.mounted) return; // ¡Importante!
    final controllers = ref.read(controllersProvider);
    updateContent(controllers.quillController.document);
  }

  void updateTitle(String title) {
    if (ref.mounted) {
      state = state.copyWith(title: title);
    }
  }

  void updateContent(Document document) {
    if (ref.mounted) {
      state = state.copyWith(content: jsonEncode(document.toDelta().toJson()));
    }
  }

  Future<Note> saveNote() async {
    if (state.isEmpty) {
      throw const EmptyNoteException();
    }

    final note = state.toNote();
    final repository = ref.read(noteRepositoryProvider);
    if (state.id == null) {
      await repository.insertNote(note);
    } else {
      await repository.updateNote(note);
    }

    // Invalidar la lista de notas para refrescar
    ref.invalidate(notesListProvider);

    return note;
  }
}

class EmptyNoteException implements Exception {
  const EmptyNoteException();
  @override
  String toString() => 'La nota está vacía';
}
