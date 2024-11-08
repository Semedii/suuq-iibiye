import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuq_iibiye/models/cart_product.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/enums/order_status.dart';
import 'package:suuq_iibiye/utils/string_utilities.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.orderModel, super.key});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final List<CartProduct?> cartProducts = orderModel.cartProducts;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () =>
          AutoRouter.of(context).push(OrderDetailsRoute(id: orderModel.id)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildOrderDate(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(cartProducts.first!.imageUrl!),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...cartProducts.map((cartProduct) =>
                            _buildProductDescription(cartProduct!)),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: localizations.customerName +
                                StringUtilities.colon +
                                StringUtilities.space,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          TextSpan(
                            text: orderModel.customer.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ])),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: localizations.address +
                                StringUtilities.colon +
                                StringUtilities.space,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          TextSpan(
                            text: orderModel.address,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPriceAndStatus(context, orderModel.totalPrice),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildOrderDate() {
    return Align(
        alignment: Alignment.topRight,
        child: Text(
            DateFormat('dd/MM/yyyy hh:mm a').format(orderModel.orderedDate)));
  }

  Text _buildProductDescription(CartProduct cartProduct) {
    return Text(
      cartProduct.description,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Row _buildPriceAndStatus(BuildContext context, double price) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPrice(price),
        Row(
          children: [
            orderModel.status.icon,
            Text(
              OrderStatus.translateName(orderModel.status, localizations),
              style: const TextStyle(color: Color.fromARGB(255, 101, 92, 7)),
            )
          ],
        )
      ],
    );
  }

  SizedBox _buildImage(String imageUrl) {
    return SizedBox(
      width: 100,
      height: 130,
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }

  Text _buildPrice(double price) {
    return Text(
      "$price\$",
      style: const TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
