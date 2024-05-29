import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/product_card.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

@RoutePage()
class CategoryPage extends ConsumerWidget {
  final Category category;
  CategoryPage({required this.category, super.key});

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryToString(category)),
      ),
      body: _mapStateToWidget(context, ref, categoryState),
    );
  }

  _mapStateToWidget(BuildContext context, WidgetRef ref, CategoryState state) {
    if (state is CategoryStateInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryNotifierProvider.notifier).initPage(
              categoryToString(category),
            );
      });
    } else if (state is CategoryStateLoaded) {
      return _buildCategoryPageBody(context, state, ref);
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Column _buildCategoryPageBody(
      BuildContext context, CategoryStateLoaded state, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: state.products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = state.products[index];
              return GridTile(
                child: ProductCard(
                  product: product,
                  onRemoveProduct: () => ref
                      .read(categoryNotifierProvider.notifier)
                      .removeProduct(product.id),
                  editPrice: () => _showAPriceDialog(context, product),
                ),
              );
            },
          ),
        ),
        _builAddNewProductButton(context, state, ref)
      ],
    );
  }

  Padding _builAddNewProductButton(
      BuildContext context, CategoryStateLoaded state, WidgetRef ref) {
    return Padding(
      padding: AppStyles.edgeInsetsB48,
      child: AppButton(
          title: "Add New Product",
          onTap: () {
            _showAddProductDialog(context);
          }),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, _) {
          final categoryState = ref.watch(categoryNotifierProvider);
          return categoryState is CategoryStateLoaded
              ? _buildAddNewProductDialog(context, categoryState, ref)
              : const SizedBox.shrink();
        });
      },
    );
  }

  AlertDialog _buildAddNewProductDialog(
      BuildContext context, CategoryStateLoaded state, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add New Product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            _buildUploadImageButton(ref, state),
          ],
        ),
      ),
      actions: [
        _buildCancelButton(context),
        _buildAddButton(ref, state, context),
      ],
    );
  }

  Column _buildUploadImageButton(WidgetRef ref, CategoryStateLoaded state) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _editUserImage(ref);
          },
          child: const Text('Upload Image'),
        ),
        if (state.encodedImages != null && state.encodedImages!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check),
              Text('uploaded ${state.encodedImages?.length} file'),
            ],
          ),
      ],
    );
  }

  TextButton _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Cancel'),
    );
  }

  ElevatedButton _buildAddButton(
      WidgetRef ref, CategoryStateLoaded state, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validate input and save the product
        String description = descriptionController.text.trim();
        String price = priceController.text.trim();
        if (description.isNotEmpty && price.isNotEmpty) {
          ref.read(categoryNotifierProvider.notifier).addNewProduct(Product(
              sellerName: "",
              sellerEmail: "",
              imageUrl: state.encodedImages ?? [],
              description: description,
              price: double.parse(price),
              category: category));
          Navigator.pop(context);
        }
      },
      child: const Text('Add'),
    );
  }

  _editUserImage(WidgetRef ref) async {
    List<XFile>? pickedImage = await ImagePicker().pickMultiImage();
    if (pickedImage.isEmpty) return;

    ref
        .read(categoryNotifierProvider.notifier)
        .onProfilePhotoChanged(pickedImage);
  }

  void _showAPriceDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, _) {
          final categoryState = ref.watch(categoryNotifierProvider);
          return categoryState is CategoryStateLoaded
              ? _buildPriceDialog(context, categoryState, ref, product)
              : const SizedBox.shrink();
        });
      },
    );
  }

  AlertDialog _buildPriceDialog(BuildContext context, CategoryStateLoaded state,
      WidgetRef ref, Product product) {
    TextEditingController newPriceController = TextEditingController();
    return AlertDialog(
      title: const Text('Edit Price'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newPriceController,
              decoration: InputDecoration(hintText: product.price.toString()),
            ),
          ],
        ),
      ),
      actions: [
        _buildCancelButton(context),
        _buildSubmitButton(product, newPriceController, ref, state, context),
      ],
    );
  }

  ElevatedButton _buildSubmitButton(
      Product product,
      TextEditingController priceController,
      WidgetRef ref,
      CategoryStateLoaded state,
      BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validate input and save the product
        String price = priceController.text.trim();
        if (price.isNotEmpty) {
          ref
              .read(categoryNotifierProvider.notifier)
              .updatePrice(product, double.parse(price));
          Navigator.pop(context);
        }
      },
      child: const Text('Submit'),
    );
  }
}
