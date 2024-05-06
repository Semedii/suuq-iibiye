import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/pages/login_page.dart';
import 'package:suuq_iibiye/pages/main_page.dart';

@RoutePage()
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {    return Consumer(builder: (context, ref, _) {
      final user = ref.watch(userProvider);
      return user.value == null
          ? const LoginPage()
          : const MainPage();
    });
  }
}

final userProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});