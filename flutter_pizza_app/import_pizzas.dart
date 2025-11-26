import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  // JSON dosyasını oku
  final String jsonString = await rootBundle.loadString('assets/pizzas.json');
  final List<dynamic> pizzas = json.decode(jsonString);

  // Firestore'a yaz
  for (var pizza in pizzas) {
    final String id = pizza['pizzaId'];
    await firestore.collection('pizzas').doc(id).set(pizza);
  }

  print('✅ Tüm pizzalar "pizzas" koleksiyonuna başarıyla yüklendi!');
}
