import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/product_card.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/notifiers/category/category_notifier.dart';
import 'package:suuq_iibiye/notifiers/category/category_state.dart';
import 'package:suuq_iibiye/pages/categoryPage/add_product_dialog.dart';
import 'package:suuq_iibiye/pages/categoryPage/edit_price_dialog.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

@RoutePage()
class CategoryPage extends ConsumerWidget {
  const CategoryPage({required this.category, super.key});

  final Category category;
  
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
    BuildContext context,
    CategoryStateLoaded state,
    WidgetRef ref,
  ) {
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
          return AddProductDialog(category: category);
        });
  }

  void _showAPriceDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPriceDialog(product: product);
      },
    );
  }
}
