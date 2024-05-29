import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/order_card.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orderHistory/order_notifier.dart';
import 'package:suuq_iibiye/notifiers/orderHistory/order_state.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

@RoutePage()
class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OrderHistoryState state = ref.watch(orderHistoryNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Orders"),
        ),
        body: _mapStateToWidget(state, ref));
  }

  Widget _mapStateToWidget(OrderHistoryState state, WidgetRef ref) {
    if (state is OrderHistoryInitialState) {
      ref.read(orderHistoryNotifierProvider.notifier).initPage();
    } else if (state is OrderHistoryLoadedState) {
      return _buildOrderHistoryPage(state.orderModelList, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildOrderHistoryPage(List<OrderModel?> orderList, WidgetRef ref) {
    bool isOrderListAvailable = orderList.isNotEmpty;
    return RefreshIndicator(
      onRefresh: () async{
       ref.read(orderHistoryNotifierProvider.notifier).initPage();
      },
      child: Padding(
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
                  "No Past Order Available.",
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
