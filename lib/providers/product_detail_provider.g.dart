// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedImageHash() => r'b283b82583c698e0d397f87ddc655f1da6bf6fe6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SelectedImage extends BuildlessAutoDisposeNotifier<String> {
  late final Product product;

  String build(
    Product product,
  );
}

/// See also [SelectedImage].
@ProviderFor(SelectedImage)
const selectedImageProvider = SelectedImageFamily();

/// See also [SelectedImage].
class SelectedImageFamily extends Family {
  /// See also [SelectedImage].
  const SelectedImageFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedImageProvider';

  /// See also [SelectedImage].
  SelectedImageProvider call(
    Product product,
  ) {
    return SelectedImageProvider(
      product,
    );
  }

  @visibleForOverriding
  @override
  SelectedImageProvider getProviderOverride(
    covariant SelectedImageProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(SelectedImage Function() create) {
    return _$SelectedImageFamilyOverride(this, create);
  }
}

class _$SelectedImageFamilyOverride implements FamilyOverride {
  _$SelectedImageFamilyOverride(this.overriddenFamily, this.create);

  final SelectedImage Function() create;

  @override
  final SelectedImageFamily overriddenFamily;

  @override
  SelectedImageProvider getProviderOverride(
    covariant SelectedImageProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [SelectedImage].
class SelectedImageProvider
    extends AutoDisposeNotifierProviderImpl<SelectedImage, String> {
  /// See also [SelectedImage].
  SelectedImageProvider(
    Product product,
  ) : this._internal(
          () => SelectedImage()..product = product,
          from: selectedImageProvider,
          name: r'selectedImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedImageHash,
          dependencies: SelectedImageFamily._dependencies,
          allTransitiveDependencies:
              SelectedImageFamily._allTransitiveDependencies,
          product: product,
        );

  SelectedImageProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  String runNotifierBuild(
    covariant SelectedImage notifier,
  ) {
    return notifier.build(
      product,
    );
  }

  @override
  Override overrideWith(SelectedImage Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedImageProvider._internal(
        () => create()..product = product,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  (Product,) get argument {
    return (product,);
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedImage, String> createElement() {
    return _SelectedImageProviderElement(this);
  }

  SelectedImageProvider _copyWith(
    SelectedImage Function() create,
  ) {
    return SelectedImageProvider._internal(
      () => create()..product = product,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      product: product,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedImageProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedImageRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _SelectedImageProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedImage, String>
    with SelectedImageRef {
  _SelectedImageProviderElement(super.provider);

  @override
  Product get product => (origin as SelectedImageProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
