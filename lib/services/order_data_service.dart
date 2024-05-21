import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/models/order.dart';

class OrderDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<OrderModel?>> fetchOrders(String sellerName) async {
    try {
      final collectionRef = db.collection("orders").withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot =
          await collectionRef.where("sellerName", isEqualTo: sellerName).get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
