import 'package:aetherium_movil/core/models/note.dart';
import 'package:aetherium_movil/features/notes/data/note_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_notes_provider.g.dart';

@riverpod
Future<List<Note>> notesList(Ref ref) async {
  final repository = ref.read(noteRepositoryProvider);
  return repository.getAllNotes();
}