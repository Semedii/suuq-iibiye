import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orderDetails/order_details_state.dart';
import 'package:suuq_iibiye/services/order_data_service.dart';

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final OrderDataService _orderDataService = OrderDataService();
  OrderDetailsNotifier() : super(OrderDetailsInitialState());

  initPage(String? id) async {
    state = OrderDetailsLoadingState();
    OrderModel? order = await _orderDataService.fetchOrderByID(id);
    state = OrderDetailsLoadedState(orderModel: order!);
  }

  acceptOrder(String? orderId) async {
    if (orderId != null) {
      await _orderDataService.updateOrderStatus(
          orderId: orderId, status: 'preparing');
      initPage(orderId);
    }
  }

  sendOrder(String? orderId) async {
    if (orderId != null) {
      await _orderDataService.updateOrderStatus(
          orderId: orderId, status: 'on the way');
      initPage(orderId);
    }
  }

  deliverOrder(String? orderId) async {
    if (orderId != null) {
      await _orderDataService.updateOrderStatus(
          orderId: orderId, status: 'delivered');
      initPage(orderId);
    }
  }
}

final orderDetailsNotifierProvider =
    StateNotifierProvider.autoDispose<OrderDetailsNotifier, OrderDetailsState>(
  (ref) => OrderDetailsNotifier(),
);
