import 'package:flutter/material.dart';
import '../../routes/app_routes.dart'; // Importante para las rutas

class CustomBottomBar extends StatelessWidget {
  final int activeIndex;
  const CustomBottomBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[300],
      currentIndex: activeIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      // 1. Agregamos el tipo para que soporte más de 3 items si fuera necesario
      type: BottomNavigationBarType.fixed,
      // 2. Agregamos la lógica para cambiar de pantalla
      onTap: (index) {
        if (index == 0) Navigator.pushReplacementNamed(context, AppRoutes.home);
        if (index == 1)
          Navigator.pushReplacementNamed(context, AppRoutes.catalog);
        if (index == 2)
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.bmi,
          ); // Ruta del IMC
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ""),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.restaurant_menu,
            size: 35,
          ), // Cambiado a menú para el catálogo
          label: "",
        ),
        // 3. Cambiamos el icono de 'Person' por el de Salud/IMC
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_weight_outlined, size: 35),
          label: "",
        ),
      ],
    );
  }
}
