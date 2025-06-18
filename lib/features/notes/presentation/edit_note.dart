import 'dart:io';
import 'package:aetherium_movil/core/models/note.dart';
import 'package:aetherium_movil/features/notes/providers/controllers_provider.dart';
import 'package:aetherium_movil/features/notes/providers/note_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditNote extends ConsumerWidget {
  final Note? note;

  const EditNote({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controllers = ref.watch(controllersProvider);
    final noteNotifier = ref.read(noteNotifierProvider(note: note).notifier);

    noteNotifier.initializeControllers(controllers);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controllers.titleController,
          focusNode: controllers.titleFocusNode,
          decoration: InputDecoration(
            hintText: 'Nueva nota',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
          ),
          style: theme.textTheme.titleLarge,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => controllers.editorFocusNode.requestFocus(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Guardar',
            onPressed: () async {
              try {
                final note = await noteNotifier.saveNote();
                Navigator.pop(context, note);
              } catch (e) {
                Navigator.pop(context, e);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancelar',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        QuillSimpleToolbar(
                          controller: controllers.quillController,
                          config: QuillSimpleToolbarConfig(
                            axis: Axis.horizontal,
                            toolbarSize: 60,
                            toolbarSectionSpacing: 1,
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
                                  controllers.editorFocusNode.requestFocus();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: QuillEditor(
                      controller: controllers.quillController,
                      focusNode: controllers.editorFocusNode,
                      scrollController: controllers.editorScrollController,
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
                                  imageEmbedConfig: QuillEditorImageEmbedConfig(
                                    imageProviderBuilder: (context, imageUrl) {
                                      if (imageUrl.startsWith('file://')) {
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
          ],
        ),
      ),
    );
  }
}
