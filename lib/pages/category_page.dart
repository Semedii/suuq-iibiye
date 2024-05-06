import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/product_card.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryToString(category)), // Adjust as per your requirement
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: ProductCard(
                    product: Product(
                      sellerName: "sellerName",
                      imageUrl: "assets/images/tshirt.jpg",
                      description: "Garan/Garamad oversize ah oo madaw",
                      price: 1,
                      category: category,
                    ),
                  ),
                );
              },
            ),
          ),
        Padding(
          padding: AppStyles.edgeInsetsB48,
          child: AppButton(title: "Add New Product", onTap: (){}),
        )
        ],
      ),
    );
  }
}
