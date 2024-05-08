import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {required this.imageUrl,
      required this.customerName,
      required this.description,
      required this.address,
      required this.price,
      required this.date,
      super.key});

  final String imageUrl;
  final String customerName;
  final String description;
  final String address;
  final double price;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(imageUrl),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Customer: $customerName",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Address: $address",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDateAndPrice(price, date),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildDateAndPrice(double price, DateTime date) {
    return Row(
      children: [
        _buildPrice(price),
        const SizedBox(width: 8),
        Expanded(child: Text(DateFormat('dd/MM/yyyy hh:mm a').format(date))),
      ],
    );
  }

  SizedBox _buildImage(String imageUrl) {
    return SizedBox(
      width: 100,
      height: 130,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
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
