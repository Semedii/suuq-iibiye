import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orderHistory/order_state.dart';
import 'package:suuq_iibiye/services/auth_data_service.dart';
import 'package:suuq_iibiye/services/order_data_service.dart';

class OrderHistoryNotifier extends StateNotifier<OrderHistoryState> {
  OrderHistoryNotifier() : super(OrderHistoryInitialState());
  final AuthDataService _authDataService = AuthDataService();
  final OrderDataService _orderDataService = OrderDataService();

  initPage() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final currentUser = await _authDataService.fetchCurrentUser(userEmail);
    List<OrderModel?> orders =
        await _orderDataService.fetchPastOrders(currentUser!.name!);
    state = OrderHistoryLoadedState(orderModelList: orders);
  }
}

final orderHistoryNotifierProvider =
    StateNotifierProvider<OrderHistoryNotifier, OrderHistoryState>(
  (ref) => OrderHistoryNotifier(),
);
