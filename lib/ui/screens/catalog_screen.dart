import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../../main.dart'; // IMPORTANTE: Para acceder al themeController
import 'detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos ListenableBuilder para que la pantalla reaccione al cambio de tema
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return Scaffold(
          // CAMBIO CLAVE: Usamos el color del tema, no el amarillo fijo
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Línea decorativa superior
                Container(
                  height: 5,
                  width: 200,
                  color: themeController.isDarkMode
                      ? Colors.orange
                      : Colors.grey[600],
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 15),

                // Banner principal
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: themeController.isDarkMode
                        ? Colors.grey[800]
                        : Colors.brown[300],
                    child: const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Cuadrícula de productos
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _productCard(context, "Tradicional"),
                      _productCard(context, "Relleno Manjar"),
                      _productCard(context, "Buñuelo Oreo"),
                      _productCard(context, "Queso Extra"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomBar(activeIndex: 1),
        );
      },
    );
  }

  Widget _productCard(BuildContext context, String title) {
    final bool isDark = themeController.isDarkMode;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          // Ajustamos el color de la tarjeta según el tema
          color: isDark ? Colors.grey[850] : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: isDark
              ? Border.all(color: Colors.orange.withOpacity(0.3))
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.cookie,
                size: 50,
                color: isDark ? Colors.orange : Colors.brown,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: isDark ? Colors.orange : Colors.grey[300],
                child: Icon(
                  Icons.add_shopping_cart,
                  color: isDark ? Colors.black : Colors.black,
                  size: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.black26 : Colors.black12,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // Texto blanco en modo oscuro, negro en claro
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
