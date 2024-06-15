import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/models/feature.dart';
import 'package:suuq_iibiye/notifiers/add_product/add_product_state.dart';
import 'package:suuq_iibiye/services/image_data_service.dart';
import 'package:suuq_iibiye/services/product_data_service.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

part 'add_product_notifier.g.dart';

@Riverpod()
class AddProductNotifier extends _$AddProductNotifier {
  final ProductDataService _productDataService = ProductDataService();
  final ImageDataService _imageDataService = ImageDataService();
  @override
  AddProductState build() {
    return AddProductIdleState();
  }

  onNameChanged(String? name) {
    var lastState = state as AddProductIdleState;
    state = lastState.copyWith(name: name);
  }

  onPriceChanged(String? price) {
    var lastState = state as AddProductIdleState;
    state = lastState.copyWith(price: price);
  }

  onDescriptionChanged(String? description) {
    var lastState = state as AddProductIdleState;
    state = lastState.copyWith(description: description);
  }

  onFeaturesAdded(Feature feature) {
    var lastState = state as AddProductIdleState;
    state = lastState.copyWith(features: [...lastState.features, feature]);
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
    state = (state as AddProductIdleState).copyWith(images: files);
  }

  Future<void> addNewProduct(Category category) async {
    var lastState = state as AddProductIdleState;
    state = AddProductLoadingState();
    var ids = await _generateImageIds(lastState.images);
    await _imageDataService.uploadImage(
      lastState.images!,
      ids!,
    );
    await _productDataService.addProduct(
        category: category,
        imageUrl: ids,
        description: lastState.name!,
        price: double.parse(lastState.price!),
        features: lastState.features,
        extraDescription: lastState.description);
    state = AddProductSuccessState();
  }

  Future<List<String>?> _generateImageIds(List<XFile?>? images) async {
    List<String> imageIds = [];
    if (images == null) return imageIds;
    for (int i = 0; i < images.length; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      var id = DateTime.now().millisecondsSinceEpoch;
      imageIds.add(id.toString());
    }
    return imageIds;
  }
}
