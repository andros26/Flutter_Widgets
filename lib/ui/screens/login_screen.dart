import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/placeholder_box.dart';
// Eliminamos el import de CatalogScreen si usamos rutas nombradas

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Mejor usar el del tema
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const PlaceholderBox(text: "Buñuel Loko", color: Colors.red),
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
              // Navegamos a la HOME que acabamos de crear
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
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
              child: const Text("Inicio de sesión"),
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
