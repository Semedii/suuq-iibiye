import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  const CategoryPage({required this.category, super.key});

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
        ref
            .read(categoryNotifierProvider.notifier)
            .initPage(categoryToString(category));
      });
    } else if (state is CategoryStateLoaded) {
      return _buildCategoryPageBody(context, state.products, ref);
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Column _buildCategoryPageBody(
      BuildContext context, List<Product> products, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return GridTile(
                child: ProductCard(
                  product: product
                 
                ),
              );
            },
          ),
        ),
        Padding(
          padding: AppStyles.edgeInsetsB48,
          child: AppButton(
              title: "Add New Product",
              onTap: () {
                _showAddProductDialog(context, ref);
              }),
        )
      ],
    );
  }

  void _showAddProductDialog(BuildContext context, WidgetRef ref) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        File? selectedImage; // Store the selected image file

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
                ElevatedButton(
                  onPressed: () {
                    // Implement image upload logic here
                  },
                  child: const Text('Upload Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate input and save the product
                String description = descriptionController.text.trim();
                double? price = double.parse(priceController.text.trim());
                if (description.isNotEmpty) {
                  ref.read(categoryNotifierProvider.notifier).addNewProduct(
                      Product(
                          sellerName: "",
                          sellerEmail: "",
                          imageUrl: "",
                          description: description,
                          price: price,
                          category: category));
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
