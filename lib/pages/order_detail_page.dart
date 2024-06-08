import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/models/cart_product.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/notifiers/orders/order_notifier.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/enums/order_status.dart';
import 'package:suuq_iibiye/utils/symbol_utilities.dart';


@RoutePage()
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text(localizations.orderDetail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getImages(order.cartProducts),
            const SizedBox(height: 20),
            ..._buildProductDetails(order.cartProducts),
            _buildDetailRow(localizations.customerName+SymbolUtilities.colon, order.customer.name ?? "N/A"),
            _buildDetailRow(localizations.phoneNumber+SymbolUtilities.colon, order.sendersPhone),
            _buildDetailRow(localizations.address+SymbolUtilities.colon, order.address),
            _buildStatus(order.status, localizations),
            _buildButton(order, localizations),
          ],
        ),
      ),
    );
  }

  Widget _getImages(List<CartProduct?> cartProducts) {
    return CarouselSlider(
        items: cartProducts
            .map((cartProduct) =>
                Image.network((cartProduct?.imageUrl ?? "")))
            .toList(),
        options: CarouselOptions(viewportFraction: 1));
  }

  List<Widget> _buildProductDetails(List<CartProduct?> cartProducts) {
    return cartProducts.asMap().entries.map((entry) {
      int index = entry.key;
      var product = entry.value;
      return _buildDetailRow(
        "Product ${index + 1}:",
        product?.description ?? "No description",
      );
    }).toList();
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 50,
          ),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }

  _buildStatus(OrderStatus status, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            localizations.status,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              status.icon,
              const SizedBox(width: 4),
              Text(status.name),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(OrderModel order, AppLocalizations localizations) {
    return Consumer(builder: (context, ref, _) {
      var orderNotifier = ref.read(orderNotifierProvider.notifier);
      if (order.status == OrderStatus.pending) {
        return _buildAcceptButton(orderNotifier, order, localizations);
      } else if (order.status == OrderStatus.preparing) {
        return _buildSendButton(orderNotifier, order, localizations);
      } else if (order.status == OrderStatus.onTheWay) {
        return _buildOnTheWayAndDeliverButton(order, orderNotifier, localizations);
      }
      return Container();
    });
  }

  AppButton _buildAcceptButton(OrderNotifier orderNotifier, OrderModel order, AppLocalizations localizations,) {
    return AppButton(
      color: AppColors.green,
      title: localizations.accept,
      onTap: () => orderNotifier.acceptOrder(order.id),
    );
  }

  AppButton _buildSendButton(OrderNotifier orderNotifier, OrderModel order, AppLocalizations localizations) {
    return AppButton(
      color: AppColors.green,
      title: localizations.send,
      onTap: () => orderNotifier.sendOrder(order.id),
    );
  }

  Column _buildOnTheWayAndDeliverButton(
      OrderModel order, OrderNotifier orderNotifier, AppLocalizations localizations,) {
    return Column(
      children: [
        _buildOnTheWayText(order),
        _buildDeliverButton(orderNotifier, order, localizations),
      ],
    );
  }

  Center _buildOnTheWayText(OrderModel order) {
    return Center(
        child: Padding(
      padding: AppStyles.edgeInsetsT40,
      child: Text(
        order.status.name.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: AppColors.green,
        ),
      ),
    ));
  }

  AppButton _buildDeliverButton(OrderNotifier orderNotifier, OrderModel order, AppLocalizations localizations,) {
    return AppButton(
      color: AppColors.green,
      title: localizations.deliver,
      onTap: () => orderNotifier.deliverOrder(order.id),
    );
  }
}
