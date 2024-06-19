import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movilapp_main/ahorros.dart';
import 'package:movilapp_main/firebase_options.dart';
import 'package:movilapp_main/paginaPrincipal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaginaPrincipal(),
    );
  }
}
