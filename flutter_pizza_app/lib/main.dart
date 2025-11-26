import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app.dart';

import 'package:user_repository/user_repository.dart';
import 'package:pizza_repository/pizza_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Bu sınıf isimlerini kendi paketine göre kontrol et:
  final userRepository = FirebaseUserRepo();
  final pizzaRepository = FirebasePizzaRepo();

  runApp(
    MyApp(userRepository: userRepository, pizzaRepository: pizzaRepository),
  );
}
