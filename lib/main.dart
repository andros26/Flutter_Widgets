import 'package:flutter/material.dart';

void main() => runApp(const BunuelLokoApp());

class BunuelLokoApp extends StatelessWidget {
  const BunuelLokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buñuel Loko App',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}

// PANTALLA 1: AUTENTICACION

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD100),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _placeholderBox("Buñuel Loko", Colors.red),
            const SizedBox(height: 40),

            const CircleAvatar(
              radius: 90,
              backgroundColor: Color(0xFFF48C42),
              child: Icon(Icons.person, size: 120, color: Colors.white),
            ),
            const SizedBox(height: 40),
            _customTextField("User"),
            const SizedBox(height: 15),
            _customTextField("**********", obscure: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CatalogScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text("Inicio de sesion"),
            ),
            const SizedBox(height: 20),
            Container(height: 6, width: 80, color: Colors.grey[600]),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(activeIndex: 0),
    );
  }

  Widget _customTextField(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// PANTALLA 2: CATÁLOGO

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD100),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 200,
              color: Colors.grey[600],
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 15),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.brown[300],
                child: const Center(
                  child: Icon(Icons.fastfood, size: 80, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _productCard(context, "Tradicional"),
                  _productCard(context, "Relleno Manjar"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(activeIndex: 1),
    );
  }

  Widget _productCard(BuildContext context, String title) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            const Center(
              child: Icon(Icons.cookie, size: 50, color: Colors.brown),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.add_shopping_cart, color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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

// PANTALLA 3: DETALLE PRODUCTO

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
    return Scaffold(
      backgroundColor: const Color(0xFFFFD100),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.brown[400],
                child: const Icon(
                  Icons.fastfood,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFFFD100),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Buñuelo Loko Especial",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _priceBadge("\$ 2.500"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "El buñuelo más loko de la ciudad, siempre fresco y crujiente.",
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Personaliza tu pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildModernDropdown(),
                  const SizedBox(height: 25),
                  _buildFeaturesRow(),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      _buildQuantitySelector(),
                      const SizedBox(width: 15),
                      Expanded(child: _buildAddToCartButton()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceBadge(String price) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(
        price,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _buildModernDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _dropdownValue,
          isExpanded: true,
          items: <String>['Extra Queso', 'Con Manjar', 'Sencillo'].map((
            String val,
          ) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: (val) => setState(() => _dropdownValue = val),
        ),
      ),
    );
  }

  Widget _buildFeaturesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _featureChip(Icons.eco, "Natural"),
        _featureChip(Icons.timer, "Fresco"),
        _featureChip(Icons.star, "Loko"),
      ],
    );
  }

  Widget _featureChip(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.brown),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => setState(() => _cantidad > 1 ? _cantidad-- : null),
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
          Text(
            "$_cantidad",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          IconButton(
            onPressed: () => setState(() => _cantidad++),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("¡Producto añadido!")));
      },
      icon: const Icon(Icons.shopping_bag),
      label: const Text(
        "Añadir",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

// --- COMPONENTES REUTILIZABLES ---

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      elevation: 0,
      leading: const Icon(Icons.menu, color: Colors.black54, size: 35),
      actions: const [
        Icon(Icons.search, color: Colors.black54, size: 35),
        SizedBox(width: 15),
      ],
    );
  }
}

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
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ""),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner, size: 35),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 35), label: ""),
      ],
    );
  }
}

Widget _placeholderBox(String text, Color color) {
  return Container(
    height: 80,
    width: 300,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
  );
}
