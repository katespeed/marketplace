import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_flutter_app/domain/models/product.dart';

part 'product_detail_provider.g.dart';

@riverpod
class SelectedImage extends _$SelectedImage {
  @override
  String build(Product product) {
    return product.imageUrl;
  }

  void selectImage(String imageUrl) {
    state = imageUrl;
  }
}

@Riverpod(keepAlive: false)
List<String> productImages(ProductImagesRef ref, Product product) => [
      product.imageUrl,
      '${product.imageUrl}?v=2',
      '${product.imageUrl}?v=3',
      '${product.imageUrl}?v=4',
      '${product.imageUrl}?v=5',
      '${product.imageUrl}?v=6',
    ]; 