import 'package:flutter/material.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/catalog_screen.dart';
import '../ui/screens/detail_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/bmi_screen.dart'; // 1. Importamos la nueva pantalla

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String catalog = '/catalog';
  static const String detail = '/detail';
  static const String bmi = '/bmi'; // 2. Definimos la constante de la ruta

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      login: (context) => const LoginScreen(),
      catalog: (context) => const CatalogScreen(),
      detail: (context) => const DetailScreen(),
      bmi: (context) => const BmiScreen(), // 3. Registramos la ruta
    };
  }
}
