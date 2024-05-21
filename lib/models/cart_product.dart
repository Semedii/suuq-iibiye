

import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

class CartProduct {
  final String? id;
  final String sellerName;
  final String? imageUrl;
  final String description;
  final double price;
  final Category category;

  CartProduct({
    required this.id,
    required this.sellerName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      sellerName: json['seller_name'],
      description: json['description'],
      imageUrl: json['image'],
      price: double.parse(json['price']),
      category: getCategoryFromString(json['category']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "seller_name": sellerName,
      "image": imageUrl,
      "description": description,
      "price": price.toStringAsFixed(2),
      "category": categoryToString(category),
    };
  }

  static mapProductToCartProduct({String? id, required Product product}) {
    return CartProduct(
      id: id ?? product.id,
      sellerName: product.sellerName,
      imageUrl: product.imageUrl.first,
      description: product.description,
      price: product.price,
      category: product.category,
    );
  }
}
