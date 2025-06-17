class NoteState {
  final String title;
  final String content;

  NoteState({required this.title, required this.content});

  NoteState copyWith({String? title, String? content}) {
    return NoteState(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  bool get isEmpty => title.trim().isEmpty && content.isEmpty;
}
