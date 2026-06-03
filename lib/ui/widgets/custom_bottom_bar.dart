import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../main.dart'; // Para acceder al themeController

class CustomBottomBar extends StatelessWidget {
  final int activeIndex;
  const CustomBottomBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final bool isDark = themeController.isDarkMode;

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.5 : 0.08),
                blurRadius: 10,
                offset: const Offset(0, -3), // Proyecta la sombra hacia arriba
              ),
            ],
          ),
          child: ClipRRect(
            // Redondeamos las esquinas superiores para un acabado premium
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: BottomNavigationBar(
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              currentIndex: activeIndex,
              // Color del icono seleccionado (Naranja de la marca)
              selectedItemColor: isDark ? Colors.orange : Colors.orange[800],
              // Color de los iconos inactivos
              unselectedItemColor: isDark ? Colors.grey[500] : Colors.black38,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels:
                  false, // Oculta etiquetas para mantenerlo limpio como tu diseño
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (index) {
                if (index == 0)
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                if (index == 1)
                  Navigator.pushReplacementNamed(context, AppRoutes.catalog);
                if (index == 2)
                  Navigator.pushReplacementNamed(context, AppRoutes.bmi);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded, size: 32),
                  label: "Inicio",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu_rounded, size: 32),
                  label: "Catálogo",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monitor_weight_rounded, size: 32),
                  label: "IMC",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
