import 'package:suuq_iibiye/models/product.dart';

abstract class CategoryState {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateLoaded extends CategoryState {
  final List<Product> products;
  final String category;
  final String? encodedImage;

  CategoryStateLoaded({
    required this.products,
    required this.category,
    this.encodedImage,
  });

  CategoryStateLoaded copyWith({
    List<Product>? products,
    String? category,
    String? encodedImage,
  }) {
    return CategoryStateLoaded(
        products: products ?? this.products,
        category: category ?? this.category,
        encodedImage: encodedImage ?? this.encodedImage);
  }
}
