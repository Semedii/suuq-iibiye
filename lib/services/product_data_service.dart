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
      final collectionRef = db.collection('products').where("category", isEqualTo: category.toLowerCase())

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
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product product, options) => product.toFirestore(),
        )
        .doc();
    await docRef.set(product);
  }

  Future<void> updatePriceAndDescription(
      {required Product product, required double newPrice, required String description}) async {
    final priceData = {"price": newPrice, "description": description};
    db
        .collection('products')
        .doc(product.id)
        .update(priceData);
  }

  Future<void> deleteProduct({
    required String productId,
    required String category,
  }) async {
    db
        .collection('products')
        .doc(productId)
        .delete();
  }
}
