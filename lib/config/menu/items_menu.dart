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
const appMenuItems=<MenuItem>[
  MenuItem(
    title:'Brillo' ,
    link: '/home',
    icon:Icons.home_outlined ,
  ),    
  MenuItem(
    title:'Contraste' ,
    link: '/history',
    icon:Icons.history_outlined ,
  ), 
  MenuItem(
    title:'Tranformaciones Gamma' ,
    link: '/config',
    icon:Icons.settings_outlined,
  ), 
  MenuItem(
    title:'Negativo imagen' ,
    link: '/theme',
    icon:Icons.color_lens_outlined,
  ),
  MenuItem(
    title:'Cuantización de niveles' ,
    link: '/login',
    icon:Icons.login_outlined ,
  ),   
    MenuItem(
    title:'Desenfoque Gaussiano' ,
    link: '/logout',
    icon:Icons.logout_outlined ,
  ),  
    MenuItem(
    title:'Filtro mediana' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ),
   MenuItem(
    title:'Filtro de enfoque' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ),  
   MenuItem(
    title:'Detección de bordes' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ),    
     MenuItem(
    title:'Erosión' ,
    link: '/Erosion',
    icon:Icons.question_answer_outlined ,
  ), 
     MenuItem(
    title:'Dilatación' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ), 
  MenuItem(
    title:'Apertura' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ), 
    MenuItem(
    title:'Cierre' ,
    link: '/help',
    icon:Icons.question_answer_outlined ,
  ),
];