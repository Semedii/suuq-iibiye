import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/models/item.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Item>?> fetchAllProducts() async {
    try {
      final collectionRef = db.collection("products").withConverter(
            fromFirestore: Item.fromFirestore,
            toFirestore: (item, _) => item.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Item> items = querySnapshot.docs.map((doc) => doc.data()).toList();
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    }
  }

  Future<List<Item>?> fetchProductsByCategory(String category) async {
    try {
      final collectionRef = db
          .collection("products")
          .where('category', isEqualTo: category.toLowerCase())
          .withConverter(
            fromFirestore: Item.fromFirestore,
            toFirestore: (item, _) => item.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Item> items = querySnapshot.docs.map((doc) => doc.data()).toList();
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    }
  }

  Future<void> addProduct(Item item) async {
    final docRef = db
        .collection("products")
        .withConverter(
          fromFirestore: Item.fromFirestore,
          toFirestore: (Item item, options) => item.toFirestore(),
        )
        .doc();
    await docRef.set(item);
  }
}
