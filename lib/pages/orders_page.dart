import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/order_card.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orders/order_notifier.dart';
import 'package:suuq_iibiye/notifiers/orders/order_state.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OrderState orderState = ref.watch(orderNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(localizations.activeOrders),
        ),
        body: _mapStateToWidget(orderState, ref, localizations));
  }

  Widget _mapStateToWidget(
    OrderState state,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    if (state is OrderInitialState) {
      ref.read(orderNotifierProvider.notifier).initPage();
    } else if (state is OrderLoadedState) {
      return _buildOrderPageBody(state.orderModelList, ref, localizations);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildOrderPageBody(
    List<OrderModel?> orderList,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    bool isOrderListAvailable = orderList.isNotEmpty;
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(orderNotifierProvider.notifier).initPage();
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
            : Center(
                child: Text(
                  localizations.noActiveOrders,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
