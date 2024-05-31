import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';

class EditProductDialog extends ConsumerWidget {
  const EditProductDialog({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryNotifierProvider);
    return categoryState is CategoryStateLoaded
        ? _buildPriceDialog(context, categoryState, ref, product)
        : const SizedBox.shrink();
  }

  AlertDialog _buildPriceDialog(BuildContext context, CategoryStateLoaded state,
      WidgetRef ref, Product product) {
    TextEditingController priceController = TextEditingController(text: product.price.toString());
    TextEditingController descriptionController = TextEditingController(text: product.description);
    return AlertDialog(
      title: const Text('Edit Price'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: product.price.toString()),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: product.description),
            ),
          ],
        ),
      ),
      actions: [
        _buildCancelButton(context),
        _buildSubmitButton(product, priceController, descriptionController ,ref, context),
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

  ElevatedButton _buildSubmitButton(
      Product product,
      TextEditingController priceController,
      TextEditingController descriptionController,
      WidgetRef ref,
      BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String price = priceController.text.trim();
        String description = descriptionController.text.trim();
        if (price.isNotEmpty && description.isNotEmpty) {
          ref
              .read(categoryNotifierProvider.notifier)
              .updatePriceAndDescription(product, double.parse(price), description);
          Navigator.pop(context);
        }
      },
      child: const Text('Submit'),
    );
  }
}
