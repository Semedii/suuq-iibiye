import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuq_iibiye/models/cart_product.dart';
import 'package:suuq_iibiye/models/order.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/symbol_utilities.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.orderModel, super.key});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final List<CartProduct?> cartProducts = orderModel.cartProducts;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () =>
          AutoRouter.of(context).push(OrderDetailsRoute(order: orderModel)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                                SymbolUtilities.colon +
                                SymbolUtilities.space,
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
                                SymbolUtilities.colon +
                                SymbolUtilities.space,
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
              _buildDateAndPrice(orderModel.totalPrice, orderModel.orderedDate),
            ],
          ),
        ),
      ),
    );
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

  Row _buildDateAndPrice(double price, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPrice(price),
        Text(DateFormat('dd/MM/yyyy hh:mm a').format(date)),
        Row(
          children: [
            orderModel.status.icon,
            const SizedBox(width: 4),
            Text(orderModel.status.name),
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
