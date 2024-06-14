import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/edit_product/edit_product_state.dart';

class EditProductNotifier extends StateNotifier<EditProductState> {
  EditProductNotifier() : super(EditProductInitialState());

  initPage(Product product) {
    state = EditProductLoadedState(
      name: product.description,
      price: product.price,
      description: product.extraDescription,
      features: product.features,
    );
  }
}

final editProductNotifierProvider =
    StateNotifierProvider<EditProductNotifier, EditProductState>(
        (ref) => EditProductNotifier());
