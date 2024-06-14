import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/edit_product/edit_product_state.dart';
import 'package:suuq_iibiye/services/product_data_service.dart';

class EditProductNotifier extends StateNotifier<EditProductState> {
  final ProductDataService _productDataService = ProductDataService();
  EditProductNotifier() : super(EditProductInitialState());

  initPage(String productId) async{
    Product product = await _productDataService.fetchProductsById(productId);
    state = EditProductLoadedState(
      name: product.description,
      price: product.price,
      description: product.extraDescription,
      features: product.features,
    );
  }

  onProductNameChanged(String productName) {
    var lastState = state as EditProductLoadedState;
    state = lastState.copyWith(name: productName);
  }

  onPriceChanged(String price) {
    var lastState = state as EditProductLoadedState;
    state = lastState.copyWith(price: double.parse(price));
  }

  onDescriptionChanged(String description) {
    var lastState = state as EditProductLoadedState;
    state = lastState.copyWith(description: description);
  }

  onUpdate(String productId) async {
    var lastState = state as EditProductLoadedState;
    state = EditProductLoadingState();
    await _productDataService.updateProduct(
      productId: productId,
      newPrice: lastState.price,
      newDescription: lastState.description,
      newName: lastState.name,
      newFeature: lastState.features,
    );
    await initPage(productId);
  }
}

final editProductNotifierProvider =
    StateNotifierProvider.autoDispose<EditProductNotifier, EditProductState>(
        (ref) => EditProductNotifier());
