import 'package:app_vs/config/presentacion/screens/filtros_elementales/brillo_screen.dart';
import 'package:app_vs/config/presentacion/screens/filtros_elementales/contraste_screen.dart';
import 'package:app_vs/config/presentacion/screens/filtros_elementales/cuatificacion_screen.dart';
import 'package:app_vs/config/presentacion/screens/filtros_elementales/negativo_screen.dart';
import 'package:app_vs/config/presentacion/screens/filtros_elementales/tranformaciones_screen.dart';
import 'package:app_vs/config/presentacion/screens/filtros_espaciales/bordes.dart';
import 'package:app_vs/config/presentacion/screens/filtros_espaciales/desonfoque.dart';
import 'package:app_vs/config/presentacion/screens/filtros_espaciales/enfoque.dart';
import 'package:app_vs/config/presentacion/screens/filtros_espaciales/mediana.dart';
import 'package:app_vs/config/presentacion/screens/home.dart';
import 'package:app_vs/config/presentacion/screens/operaciones_morfologicas/apertura.dart';
import 'package:app_vs/config/presentacion/screens/operaciones_morfologicas/cierre.dart';
import 'package:app_vs/config/presentacion/screens/operaciones_morfologicas/dilatacion.dart';
import 'package:app_vs/config/presentacion/screens/operaciones_morfologicas/erosion.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    // Filtros elementales
    GoRoute(
      path: '/Brillo',
      name: BrilloScreen.name,
      builder: (context, state) => const BrilloScreen(),
    ),
    GoRoute(
      path: '/Cuantizacion',
      name: CuatificacionScreen.name,
      builder: (context, state) => const CuatificacionScreen(),
    ),

    GoRoute(
      path: '/Contraste',
      name: ContrasteScreen.name,
      builder: (context, state) => const ContrasteScreen(),
    ),
    GoRoute(
      path: '/Tranformaciones',
      name: TranformacionesScreen.name,
      builder: (context, state) => const TranformacionesScreen(),
    ),
    GoRoute(
      path: '/Negativo',
      name: NegativoScreen.name,
      builder: (context, state) => const NegativoScreen(),
    ),
    GoRoute(
      path: '/Desenfoque',
      name: DesonfoqueScreen.name,
      builder: (context, state) => const DesonfoqueScreen(),
    ),
    // Filtros espaciales
    GoRoute(
      path: '/Mediana',
      name: MedianaScreen.name,
      builder: (context, state) => const MedianaScreen(),
    ),
    GoRoute(
      path: '/Enfoque',
      name: EnfoqueScreen.name,
      builder: (context, state) => const EnfoqueScreen(),
    ),
      GoRoute(
      path: '/Bordes',
      name: BordesScreen.name,
      builder: (context, state) => const BordesScreen(),
    ),
  
    // Operaciones morfologicas
    GoRoute(
      path: '/Erosion',
      name: ErosionScreen.name,
      builder: (context, state) => const ErosionScreen(),
    ),
    GoRoute(
      path: '/Dilatacion',
      name: DilatacionScreen.name,
      builder: (context, state) => const DilatacionScreen(),
    ),
    GoRoute(
      path: '/Apertura',
      name: AperturaScreen.name,
      builder: (context, state) => const AperturaScreen(),
    ),
    GoRoute(
      path: '/Cierre',
      name: CierreScreen.name,
      builder: (context, state) => const CierreScreen(),
    ),
  ],
);