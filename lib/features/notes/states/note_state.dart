import 'package:aetherium_movil/core/models/note.dart';

class NoteState {
  final String? id;
  final String title;
  final String content;

  NoteState({
    this.id,
    required this.title,
    required this.content,
  });

  NoteState copyWith({
    String? id,
    String? title,
    String? content,
  }) {
    return NoteState(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  bool get isEmpty => title.trim().isEmpty && content.isEmpty;

  Note toNote() => Note(
        id: id,
        title: title.isEmpty ? 'Sin título' : title,
        content: content,
        updatedAt: id != null ? DateTime.now() : null,
      );

  factory NoteState.fromNote(Note? note) => NoteState(
        id: note?.id,
        title: note?.title ?? '',
        content: note?.content ?? '',
      );
}