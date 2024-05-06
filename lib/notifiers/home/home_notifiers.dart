import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/notifiers/home/home_state.dart';
import 'package:suuq_iibiye/services/categories_data_service.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

part 'home_notifiers.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    return HomeStateInitial();
  }

  void initPage()async{
    state = HomeStateLoading();
    final List<Category?> categories =  await CategoriesDataService().fetchCategoryTypes();
    state = HomeStateLoaded(categories: categories);
  }
}
