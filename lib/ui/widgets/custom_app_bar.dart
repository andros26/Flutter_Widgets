import 'package:flutter/material.dart';
import '../../main.dart'; // Para acceder al themeController

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final bool isDark = themeController.isDarkMode;

        return AppBar(
          // Si es modo oscuro usa gris oscuro, si es claro se integra con el fondo o un tono suave
          backgroundColor: isDark
              ? Colors.grey[900]
              : Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          // Cambiamos el Icon plano por un IconButton funcional para abrir el Drawer
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: isDark ? Colors.orange : Colors.black87,
            iconSize: 32,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Text(
            "Buñuelo Loko",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: 1.2,
            ),
          ),
          actions: [
            // Botón de búsqueda estilizado
            IconButton(
              icon: const Icon(Icons.search),
              color: isDark ? Colors.orange : Colors.black54,
              iconSize: 32,
              onPressed: () {
                // Aquí irá la lógica de búsqueda del catálogo más adelante
              },
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
