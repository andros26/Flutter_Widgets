import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'logic/state_manager/theme_controller.dart';
import 'logic/state_manager/cart_controller.dart'; // <--- Asegúrate de que esta ruta sea correcta
import 'routes/app_routes.dart';

// 1. Instancias globales
final ThemeController themeController = ThemeController();
final CartController cartController =
    CartController(); // <--- ¡ESTA ES LA LÍNEA QUE FALTABA!

void main() => runApp(const BunuelLokoApp());

class BunuelLokoApp extends StatelessWidget {
  const BunuelLokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buñuel Loko App',
          themeMode: themeController.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: AppRoutes.home,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
