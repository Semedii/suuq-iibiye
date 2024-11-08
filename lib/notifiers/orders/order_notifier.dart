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
        await _orderDataService.fetchCurrentOrders(currentUser!.name!);
    state = OrderLoadedState(orderModelList: orders);
  }
}

final orderNotifierProvider = StateNotifierProvider.autoDispose<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);
