import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Products"),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
      ],
      ),
      body: GridView.builder(
        padding: AppStyles.edgeInsetsH16,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 20, // Total number of items
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/tshirt.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue[100 * (index % 9)],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.5, 0.5),
                  )
                ],
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Text(
                    "Clothes",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
