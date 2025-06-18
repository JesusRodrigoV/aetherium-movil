import 'package:aetherium_movil/core/models/note.dart';
import 'package:aetherium_movil/core/providers/list_notes_provider.dart';
import 'package:aetherium_movil/features/notes/presentation/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notesAsync = ref.watch(notesListProvider);

    return Scaffold(
      body: notesAsync.when(
        data: (notes) => notes.isEmpty
            ? const Center(
                child: Text(
                  'No hay notas.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(
                      note.title.isEmpty ? 'Sin título' : note.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Creado: ${DateFormat('dd/MM/yyyy HH:mm').format(note.createdAt)}',
                      style: theme.textTheme.bodySmall,
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditNote(note: note),
                        ),
                      );
                      if (result != null && mounted) {
                        if (result is Note) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Nota guardada')),
                          );
                        } else if (result is Exception) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result.toString().replaceFirst('Exception: ', ''),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Error al cargar notas: $e',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditNote()),
          );
          if (result != null && mounted) {
            if (result is Note) {
              ref.invalidate(notesListProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nota guardada')),
              );
            } else if (result is Exception) {
              ref.invalidate(notesListProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    result.toString().replaceFirst('Exception: ', ''),
                  ),
                ),
              );
            }
          }
        },
        tooltip: 'Nueva nota',
        child: const Icon(Icons.add),
      ),
    );
  }
}
