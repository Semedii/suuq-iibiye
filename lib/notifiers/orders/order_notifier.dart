import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orders/order_state.dart';
import 'package:suuq_iibiye/services/auth_data_service.dart';
import 'package:suuq_iibiye/services/order_data_service.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderInitialState());
  final AuthDataService _authDataService = AuthDataService();
  final OrderDataService _orderDataService = OrderDataService();

  initPage() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final currentUser = await _authDataService.fetchCurrentUser(userEmail);
    List<OrderModel?> orders =
        await _orderDataService.fetchOrders(currentUser!.name!);
    state = OrderLoadedState(orderModelList: orders);
  }

  acceptOrder(String? orderId) async {
    if (orderId != null) {
      await _orderDataService.updateOrderStatus(
          orderId: orderId, status: 'preparing');
      initPage();
    }
  }

  sendOrder(String? orderId) async {
    if (orderId != null) {
      await _orderDataService.updateOrderStatus(
          orderId: orderId, status: 'on the way');
      initPage();
    }
  }
}

final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);
