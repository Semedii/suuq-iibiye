import 'package:image_picker/image_picker.dart';
import 'package:suuq_iibiye/models/product.dart';

abstract class CategoryState {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateLoaded extends CategoryState {
  final List<Product> products;
  final String category;
  final List<XFile?>? images;

  CategoryStateLoaded({
    required this.products,
    required this.category,
    this.images,
  });

  CategoryStateLoaded copyWith({
    List<Product>? products,
    String? category,
    List<XFile?>? images,
  }) {
    return CategoryStateLoaded(
        products: products ?? this.products,
        category: category ?? this.category,
        images: images ?? this.images);
  }
}
