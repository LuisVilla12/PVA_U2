import 'package:app_vs/config/presentacion/screens/home.dart';
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
    GoRoute(
      path: '/Erosion',
      name: ErosionScreen.name,
      builder: (context, state) => const ErosionScreen(),
    ),
  ],
);