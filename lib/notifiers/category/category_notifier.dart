import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:suuq_iibiye/services/image_data_service.dart';
import 'package:suuq_iibiye/services/product_data_service.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';
part 'category_notifier.g.dart';

@Riverpod()
class CategoryNotifier extends _$CategoryNotifier {
  @override
  CategoryState build() {
    return CategoryStateInitial();
  }

  initPage(String category) async {
    state = CategoryStateLoading();
    final List<Product> products =
        await ProductDataService().fetchProductsByCategory(category);
    final List<Product> productsWithImages = [];
    for (Product product in products) {
      List<String> newImageUrls = [];
      for (String? imageUrl in product.imageUrl) {
        var newImageUrl =
            await ImageDataService().retrieveImageUrl(imageUrl);
        newImageUrls.add(newImageUrl);
      }
      product = product.copyWith(imageUrl: newImageUrls);
      productsWithImages.add(product);
    }
    state = CategoryStateLoaded(
      products: productsWithImages,
      category: category,
    );
  }


  Future<void> removeProduct(Product product) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService()
        .deleteProduct(productId: product.id, category: categoryToString(product.category));
    await ImageDataService().deleteImage(product.imageUrl);
    await initPage(lastState.category);
  }

}
