// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NoteRepository)
const noteRepositoryProvider = NoteRepositoryProvider._();

final class NoteRepositoryProvider
    extends $NotifierProvider<NoteRepository, NoteRepository> {
  const NoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteRepositoryHash();

  @$internal
  @override
  NoteRepository create() => NoteRepository();

  @$internal
  @override
  $NotifierProviderElement<NoteRepository, NoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<NoteRepository>(value),
    );
  }
}

String _$noteRepositoryHash() => r'ed5d60aa07fe04a76776c4f54db1c5166043cc07';

abstract class _$NoteRepository extends $Notifier<NoteRepository> {
  NoteRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NoteRepository>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NoteRepository>,
              NoteRepository,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
