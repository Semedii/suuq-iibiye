import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

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
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price);
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
    List<String> encodedImages = [];
    for (XFile? file in files) {
      if (file != null) {
        File compressedFile = await compressAndResizeImage(file);
        XFile compressedXfile = XFile(compressedFile.path);
        Uint8List image = await compressedXfile.readAsBytes();
        String encodedImage = base64Encode(image);
        encodedImages.add(encodedImage);
      }
    }
    state =
        (state as CategoryStateLoaded).copyWith(encodedImages: encodedImages);
  }

  Future<void> removeProduct(String productId) async {
    var lastState = state as CategoryStateLoaded;
    state = CategoryStateLoading();
    await ProductDataService()
        .deleteProduct(productId: productId, category: lastState.category);
    await initPage(lastState.category);
  }

  Future<File> compressAndResizeImage(XFile fille) async {
    File file = File(fille.path);

    img.Image image = img.decodeImage(file.readAsBytesSync())!;

    // Resize the image to have the longer side be 800 pixels
    int width;
    int height;

    if (image.width > image.height) {
      width = 800;
      height = (image.height / image.width * 800).round();
    } else {
      height = 800;
      width = (image.width / image.height * 800).round();
    }

    img.Image resizedImage =
        img.copyResize(image, width: width, height: height);

    // Compress the image with JPEG format
    List<int> compressedBytes =
        img.encodeJpg(resizedImage, quality: 75); // Adjust quality as needed

    // Save the compressed image to a file
    File compressedFile =
        File(file.path.replaceFirst('.jpg', '_compressed.jpg'));
    compressedFile.writeAsBytesSync(compressedBytes);

    return compressedFile;
  }
}
