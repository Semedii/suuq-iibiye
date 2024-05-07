import 'package:suuq_iibiye/models/product.dart';

abstract class CategoryState {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateLoaded extends CategoryState {
  final List<Product> products;
  final String category;
  final List<String?>? encodedImages;

  CategoryStateLoaded({
    required this.products,
    required this.category,
    this.encodedImages,
  });

  CategoryStateLoaded copyWith({
    List<Product>? products,
    String? category,
    List<String>? encodedImages,
  }) {
    return CategoryStateLoaded(
        products: products ?? this.products,
        category: category ?? this.category,
        encodedImages: encodedImages ?? this.encodedImages);
  }
}
