// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NoteNotifier)
const noteNotifierProvider = NoteNotifierFamily._();

final class NoteNotifierProvider
    extends $NotifierProvider<NoteNotifier, NoteState> {
  const NoteNotifierProvider._({
    required NoteNotifierFamily super.from,
    required Note? super.argument,
  }) : super(
         retry: null,
         name: r'noteNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteNotifierHash();

  @override
  String toString() {
    return r'noteNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NoteNotifier create() => NoteNotifier();

  @$internal
  @override
  $NotifierProviderElement<NoteNotifier, NoteState> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<NoteState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NoteNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteNotifierHash() => r'8f139b9944b160078ea0c6b05231f56927e6b9f0';

final class NoteNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          NoteNotifier,
          NoteState,
          NoteState,
          NoteState,
          Note?
        > {
  const NoteNotifierFamily._()
    : super(
        retry: null,
        name: r'noteNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NoteNotifierProvider call({Note? note}) =>
      NoteNotifierProvider._(argument: note, from: this);

  @override
  String toString() => r'noteNotifierProvider';
}

abstract class _$NoteNotifier extends $Notifier<NoteState> {
  late final _$args = ref.$arg as Note?;
  Note? get note => _$args;

  NoteState build({Note? note});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(note: _$args);
    final ref = this.ref as $Ref<NoteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NoteState>,
              NoteState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
