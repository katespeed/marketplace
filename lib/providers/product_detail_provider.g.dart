// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productImagesHash() => r'3673ccc2ae3f42fadc43ae43c42095ca99d3b6f2';

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

/// See also [productImages].
@ProviderFor(productImages)
const productImagesProvider = ProductImagesFamily();

/// See also [productImages].
class ProductImagesFamily extends Family<List<String>> {
  /// See also [productImages].
  const ProductImagesFamily();

  /// See also [productImages].
  ProductImagesProvider call(
    Product product,
  ) {
    return ProductImagesProvider(
      product,
    );
  }

  @override
  ProductImagesProvider getProviderOverride(
    covariant ProductImagesProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productImagesProvider';
}

/// See also [productImages].
class ProductImagesProvider extends AutoDisposeProvider<List<String>> {
  /// See also [productImages].
  ProductImagesProvider(
    Product product,
  ) : this._internal(
          (ref) => productImages(
            ref as ProductImagesRef,
            product,
          ),
          from: productImagesProvider,
          name: r'productImagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productImagesHash,
          dependencies: ProductImagesFamily._dependencies,
          allTransitiveDependencies:
              ProductImagesFamily._allTransitiveDependencies,
          product: product,
        );

  ProductImagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    List<String> Function(ProductImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductImagesProvider._internal(
        (ref) => create(ref as ProductImagesRef),
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
  AutoDisposeProviderElement<List<String>> createElement() {
    return _ProductImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductImagesProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductImagesRef on AutoDisposeProviderRef<List<String>> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _ProductImagesProviderElement
    extends AutoDisposeProviderElement<List<String>> with ProductImagesRef {
  _ProductImagesProviderElement(super.provider);

  @override
  Product get product => (origin as ProductImagesProvider).product;
}

String _$selectedImageHash() => r'89a15a6aa2137b12e834e8a28bd6e9b12a6b5a2e';

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
class SelectedImageFamily extends Family<String> {
  /// See also [SelectedImage].
  const SelectedImageFamily();

  /// See also [SelectedImage].
  SelectedImageProvider call(
    Product product,
  ) {
    return SelectedImageProvider(
      product,
    );
  }

  @override
  SelectedImageProvider getProviderOverride(
    covariant SelectedImageProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedImageProvider';
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
    super._createNotifier, {
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
  AutoDisposeNotifierProviderElement<SelectedImage, String> createElement() {
    return _SelectedImageProviderElement(this);
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
