// Crear las opciones del menu
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

// Clase de inicializar
const MenuItem({
  required this.title,
  required this.link,
  required this.icon,
});
}
// Definir los iteams
const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Brillo',
    link: '/Brillo',
    icon: Icons.brightness_6_outlined, // Icono de brillo
  ),    
  MenuItem(
    title: 'Contraste',
    link: '/Contraste',
    icon: Icons.contrast_outlined, // Icono de contraste
  ), 
  MenuItem(
    title: 'Tranformaciones Gamma',
    link: '/Tranformaciones',
    icon: Icons.auto_fix_high_outlined, // Icono de ajustes automáticos
  ), 
  MenuItem(
    title: 'Negativo imagen',
    link: '/Negativo',
    icon: Icons.invert_colors_outlined, // Icono de inversión de colores
  ),
  MenuItem(
    title: 'Cuantización de niveles',
    link: '/Cuantizacion',
    icon: Icons.gradient_outlined, // Icono de gradiente
  ),   
  MenuItem(
    title: 'Desenfoque Gaussiano',
    link: '/Desenfoque',
    icon: Icons.blur_on_outlined, // Icono de desenfoque
  ),  
  MenuItem(
    title: 'Filtro mediana',
    link: '/Mediana',
    icon: Icons.filter_outlined, // Icono de filtro
  ),
  MenuItem(
    title: 'Filtro de enfoque',
    link: '/Enfoque',
    icon: Icons.center_focus_strong_outlined, // Icono de enfoque
  ),  
  MenuItem(
    title: 'Detección de bordes',
    link: '/Bordes',
    icon: Icons.border_style_outlined, // Icono de bordes
  ),    
  MenuItem(
    title: 'Erosión',
    link: '/Erosion',
    icon: Icons.compress_outlined, // Icono de compresión
  ), 
  MenuItem(
    title: 'Dilatación',
    link: '/Dilatacion',
    icon: Icons.expand_outlined, // Icono de expansión
  ), 
  MenuItem(
    title: 'Apertura',
    link: '/Apertura',
    icon: Icons.highlight_alt_outlined, // Icono de apertura
  ), 
  MenuItem(
    title: 'Cierre',
    link: '/Cierre',
    icon: Icons.highlight_remove_outlined, // Icono de cierre
  ),
];