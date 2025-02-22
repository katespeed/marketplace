import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_flutter_app/domain/models/product.dart';

part 'product_detail_provider.g.dart';

@riverpod
class SelectedImage extends _$SelectedImage {
  @override
  String build(Product product) {
    return product.imageUrls.isNotEmpty ? product.imageUrls.first : '';
  }

  void selectImage(String imageUrl) {
    state = imageUrl;
  }
}
