import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.imageUrl,
    required this.sellerName,
    required this.description,
    required this.price,
    super.key,
  });

  final String imageUrl;
  final String sellerName;
  final String description;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 150,
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: 200,
              width: 150,
              fit: BoxFit.cover,
            ),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: sellerName,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " - $description",
                    style: const TextStyle(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${price.toStringAsFixed(2)}\$",
              style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
