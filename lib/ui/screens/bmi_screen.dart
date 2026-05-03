import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../../main.dart'; // Para acceder al themeController

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  BmiScreenState createState() => BmiScreenState();
}

class BmiScreenState extends State<BmiScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
  String? _category;

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;

    if (weight <= 0 || height <= 0) return;

    final double heightInMeters = height / 100;

    setState(() {
      _bmi = weight / (heightInMeters * heightInMeters);
      _category = _determineCategory(_bmi!);
    });
  }

  String _determineCategory(double bmi) {
    if (bmi < 18.5)
      return "Bajo peso";
    else if (bmi < 25)
      return "Normal";
    else if (bmi < 30)
      return "Sobrepeso";
    else
      return "Obesidad";
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        final bool isDark = themeController.isDarkMode;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const CustomAppBar(), // AppBar consistente
          body: SingleChildScrollView(
            // Evita errores de overflow al abrir el teclado
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Línea decorativa consistente con CatalogScreen
                Container(
                  height: 5,
                  width: 200,
                  color: isDark ? Colors.orange : Colors.grey[600],
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 30),

                // Tarjeta de entrada de datos
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.grey[850]
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: isDark
                        ? Border.all(color: Colors.orange.withOpacity(0.3))
                        : null,
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        _weightController,
                        'Peso (kg)',
                        Icons.monitor_weight_outlined,
                        isDark,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        _heightController,
                        'Altura (cm)',
                        Icons.height,
                        isDark,
                      ),
                      const SizedBox(height: 30),

                      ElevatedButton(
                        onPressed: _calculateBMI,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.orange
                              : Colors.brown[400],
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Calcular IMC',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Tarjeta de Resultado (solo aparece si hay cálculo)
                if (_bmi != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.brown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? Colors.orange : Colors.brown,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Tu IMC es: ${_bmi!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Categoría: $_category',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? Colors.orange : Colors.brown[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomBar(
            activeIndex: 2,
          ), // Ajusta el índice según tu navegación
        );
      },
    );
  }

  // Helper para mantener los TextField limpios y con estilo consistente
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool isDark,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: isDark ? Colors.orange : Colors.brown),
        labelStyle: TextStyle(color: isDark ? Colors.orange : Colors.brown),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: isDark ? Colors.orange : Colors.brown),
        ),
      ),
    );
  }
}
