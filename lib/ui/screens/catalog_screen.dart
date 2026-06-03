import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../../main.dart'; // Para acceder al themeController
import 'detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // 1. BASE URL apuntando al contenedor 'products' de Azure
  static const String _azureBaseUrl =
      "https://orders20251.blob.core.windows.net/products/";

  // 2. MAPEO CORREGIDO: Sin el punto antes de 'jpg' según Azure
  final Map<String, String> _productImages = {
    "Tradicional": "${_azureBaseUrl}cba88315-7e69-43de-91b0-f89cf973ed9djpg",
    "Arequipe": "${_azureBaseUrl}5d543f8f-83f2-4290-9a2a-b1cc9108b362jpg",
    "Bocadillo": "${_azureBaseUrl}3c293c8b-be57-4796-b733-bde81aaeb6c2jpg",
    "Chocolate": "${_azureBaseUrl}6dbc297a-ca4e-419d-b682-49fa360797cbjpg",
    "Pastel Fresas": "${_azureBaseUrl}1690878c-99b0-43ff-a924-1117f3537bafjpg",
    "Pastel tiramisu":
        "${_azureBaseUrl}78c24a18-d84b-4c0c-96bb-6f6c2eb995d6jpg",
    "Pastel Nutela": "${_azureBaseUrl}86d14e7e-daf1-4739-872f-31caeafd61c9jpg",
    "Pastel Chocolate":
        "${_azureBaseUrl}990658e3-d557-4571-ab88-2130e8356a64jpg",
  };

  // 3. URLs del carrusel de promociones superior
  final List<String> _bannerImages = [
    "${_azureBaseUrl}bf57b21e-ca6d-4289-87b6-963a1e2970a2jpg",
    "${_azureBaseUrl}7689642c-35b4-4d12-b845-e643a91abb63jpg",
    "${_azureBaseUrl}39e98641-0130-4662-9688-373f19030ec5jpg",
    "${_azureBaseUrl}fc17d1dc-cd58-4c66-8589-a9eafd4a3659jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final bool isDark = themeController.isDarkMode;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // El nuevo AppBar estilizado e integrado sin fondos grises planos
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Línea decorativa superior de la interfaz
                Container(
                  height: 4,
                  width: 120,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.orange : Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),

                // SECCIÓN 1: CARRUSEL DE PROMOCIONES (Banner Superior)
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: PageView.builder(
                      itemCount: _bannerImages.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          _bannerImages[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: isDark
                                  ? Colors.grey[900]
                                  : Colors.amber[100],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDark
                                  ? Colors.grey[800]
                                  : Colors.orange[300],
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.fastfood,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Promoción del Día",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // SECCIÓN 2: CUADRÍCULA DE PRODUCTOS (GridView)
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio:
                        0.95, // Ajuste para balancear la altura de las tarjetas
                    children: [
                      _productCard(context, "Tradicional"),
                      _productCard(context, "Arequipe"),
                      _productCard(context, "Bocadillo"),
                      _productCard(context, "Chocolate"),
                      _productCard(context, "Pastel Fresas"),
                      _productCard(context, "Pastel tiramisu"),
                      _productCard(context, "Pastel Nutela"),
                      _productCard(context, "Pastel Chocolate"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // El nuevo BottomBar estilizado con bordes redondeados y sombras elegantes
          bottomNavigationBar: const CustomBottomBar(activeIndex: 1),
        );
      },
    );
  }

  // COMPONENTE PARA RENDERIZAR CADA TARJETA DE BUÑUELO
  Widget _productCard(BuildContext context, String title) {
    final bool isDark = themeController.isDarkMode;
    final String? imageUrl = _productImages[title];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          // En modo claro usamos blanco semi-transparente para suavizar sobre el fondo amarillo
          color: isDark ? Colors.grey[850] : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.orange.withOpacity(0.3) : Colors.white,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // RENDERIZADO ASÍNCRONO DE LA IMAGEN DE AZURE
            Positioned.fill(
              bottom:
                  40, // Espacio reservado para la etiqueta del nombre inferior
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark ? Colors.grey[800] : Colors.amber[100],
                          child: Icon(
                            Icons.cookie,
                            size: 55,
                            color: isDark ? Colors.orange : Colors.brown,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.cookie,
                        size: 55,
                        color: isDark ? Colors.orange : Colors.brown,
                      ),
              ),
            ),

            // Botón superior derecho para añadir al carrito
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: isDark ? Colors.orange : Colors.orange[100],
                child: Icon(
                  Icons.add_shopping_cart,
                  color: isDark ? Colors.black : Colors.orange[900],
                  size: 18,
                ),
              ),
            ),

            // Franja inferior con el título del producto
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  // Un fondo oscuro sutil para que el texto resalte perfectamente
                  color: isDark ? Colors.black38 : Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
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
