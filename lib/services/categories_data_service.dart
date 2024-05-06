import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

class CategoriesDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Category?>> fetchCategoryTypes() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      final Map<String, dynamic> categoriesDoc =
          querySnapshot.docs.first.data() as Map<String, dynamic>;

      final List<String?> categoryNames =
          categoriesDoc["category name"].cast<String>();

      final List<Category> categories = categoryNames
          .map((categoryName) => getCategoryFromString(categoryName!))
          .toList();
      return categories;
    } catch (e) {
      print("Error fetching categories: $e");
    }
    return [];
  }
}
