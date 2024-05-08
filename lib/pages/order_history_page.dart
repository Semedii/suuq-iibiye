import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

@RoutePage()
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order History"),
      ),
      body: Padding(
        padding: AppStyles.edgeInsetsH16V24,
        child: ListView.builder(
          itemCount: 5, 
          itemBuilder: (context, index) {
            return _buildOrderCard(
              imageUrl: "assets/images/tshirt.jpg", 
              customerName: "Cabdisamed Ibraahim Xaaji Yuusuf",
              description: "Garamad oversize ah oo madaw",
              address: "123 Main Street, City, Country", 
              price: 23, 
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String imageUrl,
    required String customerName,
    required String description,
    required String address,
    required double price,
  }) {
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
                  _buildPrice(price),
                ],
              ),
            ),
          ],
        ),
      ),
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
