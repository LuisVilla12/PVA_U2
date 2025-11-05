import 'package:app_vs/config/menu/items_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SideMenu extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
    int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      indicatorColor: colors.primary,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        final menuItem = appMenuItems[value];
        Future.delayed(const Duration(milliseconds: 150), () {
          context.push(menuItem.link);
        });
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 15),
          child: const Text('FILTROS ELEMENTALES ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        // Muestra las primeras tres opciones del menú
        ...appMenuItems.asMap().entries.where((entry)=>entry.key<=4).map((entry) {
          final index = entry.key;
          final item = entry.value;
          return NavigationDrawerDestination(
            icon: Icon(
              item.icon,
              color: navDrawerIndex == index ? Colors.white : colors.primary,
            ),
            label: Text(
              item.title,
              style: TextStyle(
                color: navDrawerIndex == index ? Colors.white : colors.primary, fontSize: 15,
              ),
            ),
          );
        }),
        Padding(
          padding: EdgeInsets.fromLTRB(28, 0, 16, 0),
          child: Divider(
            color: colors.primary.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 16, 10),
          child: const Text('FILTROS ESPACIALES', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        // Muestra las siguientes opciones del menú 
        ...appMenuItems.asMap().entries.where((entry)=> entry.key>4 && entry.key<9).map((entry) {
          final index = entry.key;
          final item = entry.value;
          return NavigationDrawerDestination(
            icon: Icon(
              item.icon,
              color: navDrawerIndex == index ? Colors.white : colors.primary,
            ),
            label: Text(
              item.title,
              style: TextStyle(
                color: navDrawerIndex == index ? Colors.white : colors.primary,fontSize: 15,
              ),
            ),
          );
        }),
        Padding(
          padding: EdgeInsets.fromLTRB(28, 0, 16, 0),
          child: Divider(
            color: colors.primary.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 16, 10),
          child: const Text('FILTROS MORFOLOGICOS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
         ...appMenuItems.asMap().entries.where((entry)=> entry.key>8 && entry.key<13).map((entry) {
          final index = entry.key;
          final item = entry.value;
          return NavigationDrawerDestination(
            icon: Icon(
              item.icon,
              color: navDrawerIndex == index ? Colors.white : colors.primary,
            ),
            label: Text(
              item.title,
              style: TextStyle(
                color: navDrawerIndex == index ? Colors.white : colors.primary,fontSize: 15,
              ),
            ),
          );
        }),
        Padding(
          padding: EdgeInsets.fromLTRB(28, 0, 16, 0),
          child: Divider(
            color: colors.primary.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 16, 10),
          child: const Text('OTROS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        ...appMenuItems.asMap().entries.where((entry)=> entry.key>12).map((entry) {
          final index = entry.key;
          final item = entry.value;
          return NavigationDrawerDestination(
            icon: Icon(
              item.icon,
              color: navDrawerIndex == index ? Colors.white : colors.primary,
            ),
            label: Text(
              item.title,
              style: TextStyle(
                color: navDrawerIndex == index ? Colors.white : colors.primary,fontSize: 15,
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
        Center(child: const Text('VERSION: 2.1.0', style: TextStyle(fontSize: 12)))
      ],
    );
  }
}