import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:suuq_iibiye/services/product_data_service.dart';
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
    state = CategoryStateLoaded(products: products);
  }

  addNewProduct(Product product) async {
    await ProductDataService().addProduct(
        category: product.category,
        imageUrl: product.imageUrl ?? "",
        description: product.description,
        price: product.price);
  }
}
