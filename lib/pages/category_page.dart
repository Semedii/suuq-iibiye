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
      body: _mapStateToWidget(ref, categoryState),
    );
  }

  _mapStateToWidget( WidgetRef ref,CategoryState state){
    if(state is CategoryStateInitial){
       WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryNotifierProvider.notifier).initPage(categoryToString(category));
      });
    } else if (state is CategoryStateLoaded) {
      return _buildCategoryPageBody(state.products, ref);
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }


  Column _buildCategoryPageBody(List<Product> products, WidgetRef ref) {
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
                  product: Product(
                    sellerName: "sellerName",
                    sellerEmail: '',
                    imageUrl: "assets/images/tshirt.jpg",
                    description: "Garan/Garamad oversize ah oo madaw",
                    price: 1,
                    category: product.category,
                  ),
                ),
              );
            },
          ),
        ),
      Padding(
        padding: AppStyles.edgeInsetsB48,
        child: AppButton(title: "Add New Product", onTap: (){
          ref.read(categoryNotifierProvider.notifier).addNewProduct(
            Product(sellerName: "Shaal Online", sellerEmail: "shaalonline2023@gmail.com", imageUrl: "imageUrl", description: "description", price: 2, category: category)
          );
        }),
      )
      ],
    );
  }
}
