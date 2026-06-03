import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../../main.dart'; // Para acceder al themeController

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final bool isDark = themeController.isDarkMode;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const CustomAppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // 1. SOLUCIÓN AL ERROR CRÍTICO: Cambiado a FontWeight.w900
                  Text(
                    "Buñuelo Loko",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900, // <-- Corregido aquí
                      color: isDark ? Colors.orange : Colors.orange[900],
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          // Usamos Color.fromARGB o alpha para evitar el warning de withOpacity si estás en Flutter 3.22+
                          color: Colors.black.withAlpha(38),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tradición y sabor en un solo lugar",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // AVATAR DE USUARIO CON EFECTO DE ELEVACIÓN
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 102 : 25),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: isDark ? Colors.grey[850] : Colors.white,
                      child: CircleAvatar(
                        radius: 68,
                        backgroundColor: const Color(0xFFF48C42),
                        child: Icon(
                          Icons.person_pin_rounded,
                          size: 90,
                          color: isDark ? Colors.grey[900] : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // CAMPOS DE TEXTO MODERNOS
                  _customTextField(
                    context: context,
                    hint: "Usuario o Correo",
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 18),
                  _customTextField(
                    context: context,
                    hint: "Contraseña",
                    icon: Icons.lock_outline_rounded,
                    obscure: true,
                  ),

                  const SizedBox(height: 35),

                  // BOTÓN DE ACCESO CORREGIDO
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withAlpha(isDark ? 51 : 76),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.orange
                            : Colors.orange[850],
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "INGRESAR",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Línea decorativa sutil inferior
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[700] : Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomBar(activeIndex: 0),
        );
      },
    );
  }

  // WIDGET OPTIMIZADO PARA GENERAR CAMPOS DE TEXTO ELEGANTES
  Widget _customTextField({
    required BuildContext context,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    final bool isDark = themeController.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 76 : 10),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscure,
        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[500] : Colors.black38,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            icon,
            color: isDark ? Colors.orange : Colors.orange[800],
            size: 22,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}
