import 'package:image_picker/image_picker.dart';
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
            await ImageDataService().retrieveImageUrl(category, imageUrl);
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

  updatePriceAndDescription(Product product, double newPrice, String newDescription) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService()
        .updatePriceAndDescription(product: product, newPrice: newPrice,description:  newDescription);
    await initPage(lastState.category);
  }

  void onUploadImage() async {
    List<XFile>? pickedImage = await ImagePicker().pickMultiImage();
    if (pickedImage.isEmpty) return;
    _onImagesUploaded(pickedImage);
  }

  Future<void> _onImagesUploaded(List<XFile?> files) async {
    if (files.isEmpty) {
      print('user has not chosen a picture');
      return;
    }
    state = (state as CategoryStateLoaded).copyWith(images: files);
  }

  addNewProduct(Product product) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    var ids = await _generateImageIds(lastState.images);
    await ImageDataService().uploadImage(
      lastState.images!,
      categoryToString(product.category),
      ids!,
    );
    await ProductDataService().addProduct(
        category: product.category,
        imageUrl: ids,
        description: product.description,
        price: product.price);
    await initPage(lastState.category);
  }

  Future<void> removeProduct(String productId) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService()
        .deleteProduct(productId: productId, category: lastState.category);
    await initPage(lastState.category);
  }

  Future<List<String>?> _generateImageIds(List<XFile?>? images) async {
    List<String> imageIds = [];
    if (images == null) return imageIds;
    for (int i = 0; i < images.length; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      var id = DateTime.now().millisecondsSinceEpoch;
      print("waaa $id");
      imageIds.add(id.toString());
    }
    return imageIds;
  }
}
