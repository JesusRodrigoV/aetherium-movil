import 'dart:io' show File, Directory;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;

part 'controllers_provider.g.dart';

class NoteControllers {
  final TextEditingController titleController;
  final QuillController quillController;
  final FocusNode editorFocusNode;
  final FocusNode titleFocusNode;
  final ScrollController editorScrollController;

  NoteControllers({
    required this.titleController,
    required this.quillController,
    required this.editorFocusNode,
    required this.titleFocusNode,
    required this.editorScrollController,
  });

  void dispose() {
    titleController.dispose();
    quillController.dispose();
    editorFocusNode.dispose();
    titleFocusNode.dispose();
    editorScrollController.dispose();
  }
}

@riverpod
class Controllers extends _$Controllers {
  @override
  NoteControllers build() {
    final titleController = TextEditingController();
    final quillController = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
      config: QuillControllerConfig(
        clipboardConfig: QuillClipboardConfig(
          enableExternalRichPaste: true,
          onImagePaste: (imageBytes) async {
            if (kIsWeb) return null;
            final newFileName = 'note-image-${DateTime.now().toIso8601String()}.png';
            final newPath = path.join(Directory.systemTemp.path, newFileName);
            final file = await File(newPath).writeAsBytes(imageBytes, flush: true);
            return file.path;
          },
        ),
      ),
    );
    final editorFocusNode = FocusNode();
    final titleFocusNode = FocusNode();
    final editorScrollController = ScrollController();

    ref.onDispose(() {
      titleController.dispose();
      quillController.dispose();
      editorFocusNode.dispose();
      titleFocusNode.dispose();
      editorScrollController.dispose();
    });

    return NoteControllers(
      titleController: titleController,
      quillController: quillController,
      editorFocusNode: editorFocusNode,
      titleFocusNode: titleFocusNode,
      editorScrollController: editorScrollController,
    );
  }
}