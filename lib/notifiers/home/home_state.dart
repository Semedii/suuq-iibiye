import 'package:suuq_iibiye/utils/enums/category_enum.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState{}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<Category?> categories;

  HomeStateLoaded({required this.categories});

  HomeStateLoaded copyWith({List<Category>? categories}) {
    return HomeStateLoaded(categories: categories ?? this.categories);
  }
}
