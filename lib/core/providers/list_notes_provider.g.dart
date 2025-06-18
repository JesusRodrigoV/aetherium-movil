// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(notesList)
const notesListProvider = NotesListProvider._();

final class NotesListProvider
    extends $FunctionalProvider<AsyncValue<List<Note>>, FutureOr<List<Note>>>
    with $FutureModifier<List<Note>>, $FutureProvider<List<Note>> {
  const NotesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesListHash();

  @$internal
  @override
  $FutureProviderElement<List<Note>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Note>> create(Ref ref) {
    return notesList(ref);
  }
}

String _$notesListHash() => r'639bd8de48207277e0a39423947a4db58a4622e7';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
