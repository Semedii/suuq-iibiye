abstract class EditProductState {}

class EditProductInitialState extends EditProductState {}

class EditProductLoadingState extends EditProductState {}

class EditProductLoadedState extends EditProductState {
  final String name;
  final double price;
  final String? description;
  final List<Map<String, String>>? features;

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
    List<Map<String, String>>? features,
  }) {
    return EditProductLoadedState(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      features: features ?? this.features,
    );
  }
}
