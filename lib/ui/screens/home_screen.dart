import 'package:flutter/material.dart';
import '../../main.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _rutaSeleccionada = AppRoutes.home;

  // URL exacta de tu recurso en Azure Blob Storage (image_0490fc.png)
  final String _azureProfileImageUrl =
      "https://orders20251.blob.core.windows.net/users/371bdf14-71ca-40bc-afe1-7af9bb34d8e9.jpg";

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeController.isDarkMode;

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
            const SizedBox(height: 10),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- SECCIÓN DE BIENVENIDA ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(isDark ? 80 : 15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // CORRECCIÓN 1: Contenedor circular con manejo robusto de errores de red
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.orange, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withAlpha(50),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.network(
                            _azureProfileImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDark
                                    ? Colors.grey[850]
                                    : Colors.grey[200],
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 80,
                                  color: isDark
                                      ? Colors.grey[600]
                                      : Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        "¡Bienvenido de nuevo!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Jovanny Andres Alvarez Montoya",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // --- FIN SECCIÓN BIENVENIDA ---
                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _rutaSeleccionada = AppRoutes.bmi);
                    Navigator.pushNamed(context, AppRoutes.bmi);
                  },
                  icon: const Icon(Icons.health_and_safety),
                  label: const Text("Ir a Calculadora IMC"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                ),

                const SizedBox(height: 25),

                // CONTROLADOR MODO OSCURO
                Container(
                  width: 260,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListenableBuilder(
                    listenable: themeController,
                    builder: (context, child) {
                      return SwitchListTile(
                        title: const Text(
                          "Modo Oscuro",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: themeController.isDarkMode,
                        onChanged: (bool value) =>
                            themeController.toggleTheme(),
                        secondary: const Icon(
                          Icons.brightness_6,
                          color: Colors.orange,
                        ),
                        // CORRECCIÓN 2: Se removió activeColor para evitar advertencias de desuso
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        // Eliminados los warnings de withOpacity usando withAlpha universal
        selectedTileColor: Colors.orange.withAlpha(38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onTap: () {
          setState(() => _rutaSeleccionada = route);
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
