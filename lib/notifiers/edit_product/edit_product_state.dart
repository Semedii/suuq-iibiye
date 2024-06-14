import 'package:suuq_iibiye/models/feature.dart';

abstract class EditProductState {}

class EditProductInitialState extends EditProductState {}

class EditProductLoadingState extends EditProductState {}

class EditProductLoadedState extends EditProductState {
  final String name;
  final double price;
  final String? description;
  final List<Feature>? features;

  EditProductLoadedState({
   required this.name,
   required this.price,
    this.description,
    this.features = const [],
  });

  EditProductLoadedState copyWith({
    String? name,
    double? price,
    String? description,
    List<Feature>? features,
  }) {
    return EditProductLoadedState(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      features: features ?? this.features,
    );
  }
}
