import 'package:flutter/material.dart';
import '../../main.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable para rastrear qué opción del menú está resaltada
  String _rutaSeleccionada = AppRoutes.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text("Buñuel Loko"),
        actions: [
          ListenableBuilder(
            listenable: themeController,
            builder: (context, child) {
              return IconButton(
                icon: Icon(
                  themeController.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () => themeController.toggleTheme(),
              );
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                "Menú Principal",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const SizedBox(height: 10), // Espacio estético
            // --- OPCIONES CON RESALTADO ---
            _buildDrawerItem(
              icon: Icons.restaurant_menu,
              title: "Catálogo de Buñuelos",
              route: AppRoutes.catalog,
            ),
            _buildDrawerItem(
              icon: Icons.info,
              title: "Detalle de Producto",
              route: AppRoutes.detail,
            ),
            _buildDrawerItem(
              icon: Icons.calculate,
              title: "Calculadora IMC",
              route: AppRoutes.bmi,
            ),

            const Divider(),

            // CERRAR SESIÓN (Sin resaltado persistente)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar Sesión"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.login),
            ),
          ],
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, size: 100, color: Colors.orange),
              const SizedBox(height: 10),
              const Text(
                "Panel de Control",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _rutaSeleccionada = AppRoutes.bmi);
                  Navigator.pushNamed(context, AppRoutes.bmi);
                },
                icon: const Icon(Icons.health_and_safety),
                label: const Text("Ir a Calculadora IMC"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 250,
                child: ListenableBuilder(
                  listenable: themeController,
                  builder: (context, child) {
                    return SwitchListTile(
                      title: const Text("Modo Oscuro"),
                      value: themeController.isDarkMode,
                      onChanged: (bool value) => themeController.toggleTheme(),
                      secondary: const Icon(Icons.brightness_6),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // MÉTODO PARA CONSTRUIR CADA ITEM DEL MENÚ CON DISEÑO DE CÁPSULA
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String route,
  }) {
    final bool isSelected = _rutaSeleccionada == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.orange[800] : null),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange[800] : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.orange.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ), // Bordes redondeados tipo cápsula
        ),
        onTap: () {
          setState(() => _rutaSeleccionada = route); // Cambia el estado visual
          Navigator.pop(context); // Cierra el Drawer
          Navigator.pushNamed(context, route); // Navega a la ruta
        },
      ),
    );
  }
}
