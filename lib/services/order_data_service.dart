import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/models/order.dart';

class OrderDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<OrderModel?>> fetchCurrentOrders(String sellerName) async {
    try {
      final collectionRef = db.collection("orders").orderBy('orderedDate', descending: true).withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot = await collectionRef
          .where("sellerName", isEqualTo: sellerName)
          .where("status", isNotEqualTo: "delivered")
          .get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<List<OrderModel?>> fetchPastOrders(String sellerName) async {
    try {
      final collectionRef = db.collection("orders").withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot = await collectionRef
          .where("sellerName", isEqualTo: sellerName)
          .where("status", isEqualTo: "delivered")
          .get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<OrderModel?> fetchOrderByID(String? id) async {
    try {
      final collectionRef = db.collection("orders").doc(id).withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot = await collectionRef.get();
      OrderModel? order = querySnapshot.data();
      return order;
    } catch (e) {
      print("Error fetching orders: $e");
      return null;
    }
  }

  Future<void> updateOrderStatus(
      {required String orderId, required String status}) async {
    final statusData = {"status": status.toLowerCase()};
    db.collection('orders').doc(orderId).update(statusData);
  }
}
