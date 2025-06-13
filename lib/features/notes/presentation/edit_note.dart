import 'dart:convert';
import 'dart:io' show File, Directory;

import 'package:aetherium_movil/core/models/note.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart' as path;

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _titleController = TextEditingController();
  final _quillController = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
    config: QuillControllerConfig(
      clipboardConfig: QuillClipboardConfig(
        enableExternalRichPaste: true,
        onImagePaste: (imageBytes) async {
          if (kIsWeb) return null;
          final newFileName =
              'note-image-${DateTime.now().toIso8601String()}.png';
          final newPath = path.join(Directory.systemTemp.path, newFileName);
          final file = await File(
            newPath,
          ).writeAsBytes(imageBytes, flush: true);
          return file.path;
        },
      ),
    ),
  );
  final _editorFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _editorScrollController = ScrollController();

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _editorFocusNode.dispose();
    _titleFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = jsonEncode(_quillController.document.toDelta().toJson());

    if (title.isEmpty &&
        _quillController.document.toPlainText().trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('La nota está vacía')));
      return;
    }

    final note = Note(
      title: title.isEmpty ? 'Sin título' : title,
      content: content,
    );

    // TODO: Guardar la nota en la base de datos local (sqflite o hive)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nota guardada (placeholder)')),
    );

    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Nota'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Guardar',
            onPressed: _saveNote,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancelar',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              decoration: InputDecoration(
                hintText: 'Título',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
              style: theme.textTheme.titleLarge,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _editorFocusNode.requestFocus(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    QuillSimpleToolbar(
                      controller: _quillController,
                      config: QuillSimpleToolbarConfig(
                        showAlignmentButtons: false,
                        showBackgroundColorButton: false,
                        showColorButton: false,
                        showFontFamily: false,
                        showFontSize: false,
                        showHeaderStyle: true,
                        showListNumbers: true,
                        showListBullets: true,
                        showBoldButton: true,
                        showItalicButton: true,
                        showStrikeThrough: true,
                        showClipboardCut: false,
                        showClipboardCopy: false,
                        showClipboardPaste: false,
                        embedButtons: FlutterQuillEmbeds.toolbarButtons(
                          imageButtonOptions:
                              const QuillToolbarImageButtonOptions(),
                        ),
                        buttonOptions: QuillSimpleToolbarButtonOptions(
                          base: QuillToolbarBaseButtonOptions(
                            afterButtonPressed: () {
                              _editorFocusNode.requestFocus();
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: QuillEditor(
                        controller: _quillController,
                        focusNode: _editorFocusNode,
                        scrollController: _editorScrollController,
                        config: QuillEditorConfig(
                          padding: const EdgeInsets.all(8),
                          placeholder: 'Escribe tu nota aquí...',
                          autoFocus: false,
                          keyboardAppearance:
                              theme.brightness == Brightness.dark
                                  ? Brightness.dark
                                  : Brightness.light,
                          embedBuilders:
                              kIsWeb
                                  ? FlutterQuillEmbeds.editorWebBuilders()
                                  : FlutterQuillEmbeds.editorBuilders(
                                    imageEmbedConfig:
                                        QuillEditorImageEmbedConfig(
                                          imageProviderBuilder: (
                                            context,
                                            imageUrl,
                                          ) {
                                            if (imageUrl.startsWith(
                                              'file://',
                                            )) {
                                              return FileImage(
                                                File(
                                                  imageUrl.replaceFirst(
                                                    'file://',
                                                    '',
                                                  ),
                                                ),
                                              );
                                            }
                                            return null;
                                          },
                                        ),
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
