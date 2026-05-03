import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  int _counter = 0;

  // Leer el valor actual
  int get counter => _counter;

  // Método para agregar productos
  void addToCart() {
    _counter++;
    notifyListeners(); // Notifica a los widgets para que se redibujen
  }

  // Método para limpiar (opcional)
  void clearCart() {
    _counter = 0;
    notifyListeners();
  }
}
