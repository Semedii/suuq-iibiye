import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/firebase_options_prod.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/my_app.dart';

void main() async {
  await Global.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp(env: "prod")));
}
