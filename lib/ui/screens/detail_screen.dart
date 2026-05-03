import 'package:flutter/material.dart';
import '../../main.dart'; // <--- 1. ARREGLA EL ERROR DEL CARTCONTROLLER
import '../widgets/custom_bottom_bar.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _cantidad = 1;
  String? _dropdownValue = 'Extra Queso';

  @override
  Widget build(BuildContext context) {
    // 2. ESCUCHAMOS AL THEMECONTROLLER
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final isDark = themeController.isDarkMode;

        return Scaffold(
          // Cambiamos el color fijo por el del tema
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: const CustomBottomBar(activeIndex: 1),
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, isDark),
              SliverToBoxAdapter(child: _buildProductDetails(isDark)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: isDark ? Colors.orange[900] : Colors.brown[400],
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: isDark ? Colors.black54 : Colors.white70,
          child: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: Icon(Icons.fastfood, size: 100, color: Colors.white),
      ),
    );
  }

  Widget _buildProductDetails(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // COLOR DINÁMICO: Gris oscuro en dark mode, Amarillo en light mode
        color: isDark ? Colors.grey[900] : const Color(0xFFFFD100),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Buñuelo Loko Especial",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : Colors.black, // TEXTO ADAPTATIVO
                  ),
                ),
              ),
              _priceBadge("\$ 2.500", isDark),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "El buñuelo más loko de la ciudad, siempre fresco y crujiente.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 25),
          _buildModernDropdown(isDark),
          const SizedBox(height: 25),
          _buildFeaturesRow(isDark),
          const SizedBox(height: 40),
          Row(
            children: [
              _buildQuantitySelector(isDark),
              const SizedBox(width: 15),
              Expanded(child: _buildAddToCartButton(isDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceBadge(String price, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.orange : Colors.brown[700],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildModernDropdown(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _dropdownValue,
          isExpanded: true,
          dropdownColor: isDark ? Colors.grey[850] : Colors.white,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          items: <String>['Extra Queso', 'Bocadillo', 'Doble Loko']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
          onChanged: (String? newValue) {
            setState(() => _dropdownValue = newValue);
          },
        ),
      ),
    );
  }

  Widget _buildFeaturesRow(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _FeatureIcon(icon: Icons.eco, label: "Orgánico", isDark: isDark),
        _FeatureIcon(icon: Icons.timer, label: "5 min", isDark: isDark),
        _FeatureIcon(icon: Icons.star, label: "Top", isDark: isDark),
      ],
    );
  }

  Widget _buildQuantitySelector(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => setState(() => _cantidad > 1 ? _cantidad-- : null),
          ),
          Text(
            "$_cantidad",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: isDark ? Colors.white : Colors.black),
            onPressed: () => setState(() => _cantidad++),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(bool isDark) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? Colors.orange : Colors.brown,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: () {
        // LÓGICA DEL CARRITO (Ya no dará error porque importamos main.dart)
        for (int i = 0; i < _cantidad; i++) {
          cartController.addToCart();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("¡$_cantidad Buñuelo(s) agregado(s)! 🍩"),
            backgroundColor: isDark ? Colors.orange[800] : Colors.brown,
          ),
        );
      },
      child: const Text(
        "AGREGAR AL CARRITO",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  const _FeatureIcon({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: isDark ? Colors.orange : Colors.brown[700]),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }
}
