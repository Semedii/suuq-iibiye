import 'package:suuq_iibiye/models/product.dart';

abstract class CategoryState {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateLoaded extends CategoryState {
  final List<Product> products;

  CategoryStateLoaded({required this.products});

  CategoryStateLoaded copyWith({List<Product>? products}) {
    return CategoryStateLoaded(products: products ?? this.products);
  }
}
