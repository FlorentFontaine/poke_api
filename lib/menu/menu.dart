import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text('Pokedex'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Pokedex'),
            onTap: () => context.go('/'),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('List'),
            onTap: () => context.go('/list'),
          ),
        ],
      ),
    );
  }
}
