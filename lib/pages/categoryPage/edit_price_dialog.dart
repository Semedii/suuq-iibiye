import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';

class EditPriceDialog extends ConsumerWidget {
  const EditPriceDialog({required this.product, super.key});

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
