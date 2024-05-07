import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/notifiers/bottomNavbar/bottom_nav_bar_notifier.dart';
import 'package:suuq_iibiye/pages/home_page.dart';
import 'package:suuq_iibiye/pages/my_account_page.dart';
import 'package:suuq_iibiye/pages/orders_page.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(bottomNavBarNotifierProvider);
    final bodies = [
      const HomePage(),
      const OrdersPage(),
      const MyAccountPage()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: ref.read(bottomNavBarNotifierProvider.notifier).onTap,
        selectedItemColor: AppColors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off_csred_rounded), label: "My Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile")
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
