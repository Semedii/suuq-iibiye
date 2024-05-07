import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
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
    state = CategoryStateLoaded(products: products, category: category);
  }

  updatePrice(Product product, double newPrice) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService()
        .updatePrice(product: product, newPrice: newPrice);
    await initPage(lastState.category);
  }

  addNewProduct(Product product) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService().addProduct(
        category: product.category,
        imageUrl: product.imageUrl ?? "",
        description: product.description,
        price: product.price);
    await initPage(lastState.category);
  }

  Future<void> onProfilePhotoChanged(XFile? file) async {
    if (file == null) {
      print('user has not chosen a picture');
      return;
    }

    Uint8List image = await file.readAsBytes();
    String encodedImage = base64Encode(image);
    state = (state as CategoryStateLoaded).copyWith(encodedImage: encodedImage);
  }
}
