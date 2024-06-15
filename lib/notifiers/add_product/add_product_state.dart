import 'package:image_picker/image_picker.dart';
import 'package:suuq_iibiye/models/feature.dart';

abstract class AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductIdleState extends AddProductState {
  final String? name;
  final String? price;
  final String? description;
  final List<XFile?>? images;
  final List<Feature?> features;

  AddProductIdleState({
    this.name,
    this.price,
    this.images,
    this.description,
    this.features = const [],
  });

  AddProductIdleState copyWith({
    String? name,
    String? price,
    List<XFile?>? images,
    String? description,
    List<Feature?>? features,
  }) {
    return AddProductIdleState(
      name: name ?? this.name,
      price: price ?? this.price,
      images: images ?? this.images,
      description: description ?? this.description,
      features: features ?? this.features,
    );
  }
}

class AddProductSuccessState extends AddProductState {}
