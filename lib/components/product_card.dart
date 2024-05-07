import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    this.editPrice,
    required this.onRemoveProduct,
    super.key,
  });
  final Product product;
  final void Function()? editPrice;
  final void Function() onRemoveProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.memory(
                    base64Decode(product.imageUrl.first ?? ""),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(right: 0, child: _buildRemoveButton(context)),
                ],
              ),
            ),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: product.sellerName,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " - ${product.description}",
                    style: const TextStyle(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.price.toStringAsFixed(2)}\$",
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(onPressed: editPrice, icon: Icon(Icons.edit))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return GestureDetector(
      onTap:()=> _showAddProductDialog(context),
      child: Container(
          padding: AppStyles.edgeInsets4,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
    void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text("Are you sure you wanna remove this?", style: TextStyle(fontWeight:FontWeight.bold ),),
                 _buildYesButton(context),
                  _buildCancelButton(context)],),
              );
      }
    );
  }
    TextButton _buildYesButton(BuildContext context) {
    return TextButton(
      onPressed:(){
        onRemoveProduct();
        Navigator.of(context).pop();
      },
      child: const Text('Remove'),
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
}
