import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/order_card.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orders/order_notifier.dart';
import 'package:suuq_iibiye/notifiers/orders/order_state.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OrderState orderState = ref.watch(orderNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Orders"),
        ),
        body: _mapStateToWidget(orderState, ref));
  }

  Widget _mapStateToWidget(OrderState state, WidgetRef ref) {
    if (state is OrderInitialState) {
      ref.read(orderNotifierProvider.notifier).initPage();
    } else if (state is OrderLoadedState) {
      return _buildOrderPageBody(state.orderModelList);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Padding _buildOrderPageBody(List<OrderModel?> orderList) {
    bool isOrderListAvailable = orderList.isNotEmpty;
    return Padding(
      padding: AppStyles.edgeInsetsH16,
      child: isOrderListAvailable
          ? ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                if (order != null) {
                  return OrderCard(orderModel: order);
                }
                return const SizedBox.shrink();
              },
            )
          : const Center(
              child: Text(
                "No Active Order Available. You can check past orders in the Order History Page",
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
