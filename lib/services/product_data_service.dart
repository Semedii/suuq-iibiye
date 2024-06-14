import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/models/feature.dart';
import 'package:suuq_iibiye/models/product.dart';
import 'package:suuq_iibiye/services/image_data_service.dart';
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
          .collection('products')
          .where("category", isEqualTo: category.toLowerCase())
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

    Future<Product> fetchProductsById(String id) async {
    final collectionRef = db
        .collection('products')
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (product, _) => product.toFirestore(),
        );

    final querySnapshot = await collectionRef.get();
    final prodData =
        querySnapshot.docs.firstWhere((element) => element.id == id);
    List<String> newImageUrls = [];
    
    for (String? imageUrl in prodData.data().imageUrl) {
      var newImageUrl = await ImageDataService().retrieveImageUrl(imageUrl);
      newImageUrls.add(newImageUrl);
    }
    Product product = prodData.data().copyWith(imageUrl: newImageUrls);
    return product;
  }

  Future<void> addProduct({
    required Category category,
    required List<String?> imageUrl,
    required String description,
    required double price,
    List<Feature>? features,
    String? extraDescription,
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
        features: features,
        extraDescription: extraDescription);

    final docRef = db
        .collection("products")
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product product, options) => product.toFirestore(),
        )
        .doc();
    await docRef.set(product);
  }

  Future<void> updateProduct({
    required String productId,
    required double newPrice,
    required String newName,
    required String? newDescription,
    required List<Feature>? newFeature,
  }) async {
    final newData = {
      "price": newPrice,
      "description": newName,
      "extra_description": newDescription,
      "features": newFeature?.map((feature) => feature.toJson()).toList(),
    };
    db.collection('products').doc(productId).update(newData);
  }

  Future<void> deleteProduct({
    required String productId,
    required String category,
  }) async {
    db.collection('products').doc(productId).delete();
  }
}
