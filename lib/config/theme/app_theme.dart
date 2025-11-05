import 'package:flutter/material.dart';

// Define los temas de la aplicación
const List<Map<String, dynamic>> colorOptions = [
  {'name': 'Indigo Profundo', 'color': Colors.indigo},
  {'name': 'Verde Azulado', 'color': Colors.teal},
  {'name': 'Púrpura Profundo', 'color': Colors.deepPurple},
  {'name': 'Azul', 'color': Colors.blue},
  {'name': 'Verde', 'color': Colors.green},
  {'name': 'Amarillo Ámbar', 'color': Colors.amber},
  {'name': 'Naranja', 'color': Colors.orange},
  {'name': 'Púrpura', 'color': Colors.purple},
  {'name': 'Rosa Intenso', 'color': Colors.pinkAccent},
  {'name': 'Rosa', 'color': Colors.pink},
];

class AppTheme {
  
  final int selectedColor;
  final bool isDarkmode;
  
  // Clase de tema le se asigna el color
  AppTheme({
    this.selectedColor=0, 
    this.isDarkmode=false,
  }):assert(selectedColor>=0,'El color seleccionado debe ser mayor a 0'),
  assert(selectedColor<colorOptions.length,'El color seleccionado debe ser menor al color seleccionado');
  // assert es para el manejo de excepciones

  // Obtener el tema de la clase ThemDAta
  ThemeData getTheme ()=>ThemeData(
    useMaterial3: true,
    brightness: isDarkmode? Brightness.dark : Brightness.light,
    // Coloca el tema seleccionado
    colorSchemeSeed: colorOptions[selectedColor]['color'],
    appBarTheme: const AppBarTheme(
      centerTitle: false
    ),
        navigationDrawerTheme: NavigationDrawerThemeData(
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // 🔲 Bordes menos redondos
      ),
      indicatorColor: Colors.blue.shade300, // Color de fondo al seleccionar
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(color: Colors.black),
      ),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: Colors.black),
      ),
    ),
  );
}