import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/theme/app_pallete.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppPallete.accentColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(LineIcons.home),
            title: const Text('Home'),
            onTap: () {
              context.go('/home'); // Navigate to Watchlist page
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.list),
            title: const Text('Watchlist'),
            onTap: () {
              context.go('/watchlist'); // Navigate to Watchlist page
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
