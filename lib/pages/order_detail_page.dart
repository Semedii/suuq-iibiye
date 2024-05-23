import 'dart:convert';
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
import 'package:suuq_iibiye/utils/enums/order_status.dart';

@RoutePage()
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getImages(order.cartProducts),
            const SizedBox(height: 20),
            ..._buildProductDetails(order.cartProducts),
            _buildDetailRow("Customer name:", order.customer.name ?? "N/A"),
            _buildDetailRow("Phone number:", order.sendersPhone),
            _buildDetailRow("Address:", order.address),
            _buildStatus(order.status),
            _buildButton(order),
          ],
        ),
      ),
    );
  }

  Widget _getImages(List<CartProduct?> cartProducts) {
    return CarouselSlider(
        items: cartProducts
            .map((cartProduct) =>
                Image.memory(base64Decode(cartProduct?.imageUrl ?? "")))
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
         const SizedBox(width: 50,),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }

  _buildStatus(OrderStatus status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Status",
            style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildButton(OrderModel order) {
    return Consumer(builder: (context, ref, _) {
      var orderNotifier = ref.read(orderNotifierProvider.notifier);
      if (order.status == OrderStatus.pending) {
        return AppButton(
            color: AppColors.green,
            title: "Accept",
            onTap: () => orderNotifier.acceptOrder(order.id));
      } else if (order.status == OrderStatus.preparing) {
        return AppButton(
            color: AppColors.green,
            title: "Send",
            onTap: () => orderNotifier.sendOrder(order.id));
      } else if (order.status == OrderStatus.onTheWay) {
        return Column(
          children: [
            Center(
                child: Padding(
              padding: AppStyles.edgeInsetsT40,
              child: Text(
                order.status.name.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.green),
              ),
            )),
            AppButton(
                color: AppColors.green,
                title: "Deliver",
                onTap: () => orderNotifier.deliverOrder(order.id)),
          ],
        );
      }
      return Container();
    });
  }
}
