import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/utils/enums/category_enum.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Product>?> fetchAllProducts() async {
    try {
      final collectionRef = db.collection("products").withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> items =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final sellerEmail = await Global.storageService.getString("sellerEmail");
    try {
      final collectionRef = db
          .collectionGroup(category.toLowerCase())
          .where('seller_email', isEqualTo: sellerEmail)
          .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<void> addProduct({
    required Category category,
  required List<String?> imageUrl,
    required String description,
    required double price,
  }) async {
    final String categoryString = categoryToString(category);
    final sellerEmail = await Global.storageService.getString("sellerEmail");
    final sellerName = await Global.storageService.getString("sellerName");

    final Product product = Product(
      sellerName: sellerName!,
      sellerEmail: sellerEmail!,
      imageUrl: imageUrl,
      description: description,
      price: price,
      category: category,
    );

    final docRef = db
        .collection("products")
        .doc("categoriesDoc")
        .collection(categoryString)
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product product, options) => product.toFirestore(),
        )
        .doc();
    await docRef.set(product);
  }

  Future<void> updatePrice(
      {required Product product, required double newPrice}) async {
    final String categoryString = categoryToString(product.category);
    final priceData = {"price": newPrice};
    db
        .collection('products')
        .doc('categoriesDoc')
        .collection(categoryString)
        .doc(product.id)
        .update(priceData);
  }
}
