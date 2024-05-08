import 'package:flutter/material.dart';
import 'package:suuq_iibiye/components/order_card.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Orders"),
      ),
      body: Padding(
        padding: AppStyles.edgeInsetsH16V24,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return OrderCard(
                imageUrl: "assets/images/tshirt.jpg",
                customerName: "Cabdisamed Ibraahim Xaaji Yuusuf",
                description: "Garamad oversize ah oo madaw",
                address: "123 Main Street, City, Country",
                price: 23,
                date: DateTime.now());
          },
        ),
      ),
    );
  }
}
