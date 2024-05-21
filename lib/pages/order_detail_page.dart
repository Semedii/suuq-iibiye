import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/models/cart_product.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

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
            _buildDetailRow("Order Status", order.status),
            AppButton(color: AppColors.green, title: "Accept", onTap: () {}),
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
        "Product ${index + 1} Description:",
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
          Text(value),
        ],
      ),
    );
  }
}
