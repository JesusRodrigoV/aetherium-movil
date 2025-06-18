// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Controllers)
const controllersProvider = ControllersProvider._();

final class ControllersProvider
    extends $NotifierProvider<Controllers, NoteControllers> {
  const ControllersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controllersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controllersHash();

  @$internal
  @override
  Controllers create() => Controllers();

  @$internal
  @override
  $NotifierProviderElement<Controllers, NoteControllers> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteControllers value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<NoteControllers>(value),
    );
  }
}

String _$controllersHash() => r'a3847f94a9e887734585542b863cb1c0c0a9c5bf';

abstract class _$Controllers extends $Notifier<NoteControllers> {
  NoteControllers build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NoteControllers>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NoteControllers>,
              NoteControllers,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
