import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // Por defecto, iniciamos en modo claro
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Retorna el modo de tema que MaterialApp necesita
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Función para cambiar el estado y avisar a la UI
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // <--- CRUCIAL: Esto redibuja la app
  }
}
