// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:nextrade/core/theme/app_pallete.dart';
//
// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppPallete.backgroundColor,
//       child: SafeArea(
//         child: Column(
//           children: [
//             // Header section with user info and app logo
//             _buildDrawerHeader(),
//
//             // Divider between header and menu items
//             const Divider(color: AppPallete.dividerColor, height: 1),
//
//             // Menu items list
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   _buildMenuItem(
//                     context: context,
//                     icon: LineIcons.home,
//                     title: 'Home',
//                     route: '/home',
//                   ),
//                   // _buildMenuItem(
//                   //   context: context,
//                   //   icon: LineIcons.alternateExchange,
//                   //   title: 'Market',
//                   //   route: '/market',
//                   // ),
//                   _buildMenuItem(
//                     context: context,
//                     icon: LineIcons.list,
//                     title: 'Watchlist',
//                     route: '/watchlist',
//                   ),
//                   _buildMenuItem(
//                     context: context,
//                     icon: LineIcons.bookOpen,
//                     title: 'Learning',
//                     route: '/learning',
//                   ),
//                   // _buildMenuItem(
//                   //   context: context,
//                   //   icon: LineIcons.history,
//                   //   title: 'Transaction History',
//                   //   route: '/transactions',
//                   // ),
//                   // _buildMenuItem(
//                   //   context: context,
//                   //   icon: LineIcons.cog,
//                   //   title: 'Settings',
//                   //   route: '/settings',
//                   // ),
//                 ],
//               ),
//             ),
//
//             // Bottom section with logout option
//             _buildLogoutSection(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//       decoration: const BoxDecoration(
//         color: AppPallete.accentColor,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // User profile section
//           Row(
//             children: [
//               // User avatar
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.white.withOpacity(0.2),
//                 child: const Icon(
//                   LineIcons.user,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // User info
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Welcome',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'John Doe',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // App title/brand
//           const Row(
//             children: [
//               Icon(
//                 LineIcons.alternateExchange,
//                 color: Colors.white,
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'NextTrade',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMenuItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String route,
//     bool isActive = false,
//   }) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: isActive ? AppPallete.accentColor : AppPallete.iconColor,
//         size: 22,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isActive ? AppPallete.accentColor : AppPallete.textColor,
//           fontSize: 16,
//           fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//         ),
//       ),
//       dense: true,
//       visualDensity: const VisualDensity(vertical: -1),
//       onTap: () {
//         context.go(route);
//         Navigator.pop(context);
//       },
//     );
//   }
//
//   Widget _buildLogoutSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           const Divider(color: AppPallete.dividerColor, height: 1),
//           ListTile(
//             leading: const Icon(
//               LineIcons.alternateSignOut,
//               color: AppPallete.dangerColor,
//               size: 22,
//             ),
//             title: const Text(
//               'Log out',
//               style: TextStyle(
//                 color: AppPallete.dangerColor,
//                 fontSize: 16,
//               ),
//             ),
//             onTap: () {
//               // Show logout confirmation dialog
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Log out'),
//                   content: const Text('Are you sure you want to log out?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close dialog
//                         Navigator.pop(context); // Close drawer
//                         // Handle logout logic here
//                         context.go('/login');
//                       },
//                       child: const Text('Log out'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'App Version 1.0.3',
//               style: TextStyle(
//                 color: Colors.grey[500],
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/theme/app_pallete.dart';
// import 'package:nextrade/features/auth/cubit/app_user_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppPallete.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(),
            const Divider(color: AppPallete.dividerColor, height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(context: context, icon: LineIcons.home, title: 'Home', route: '/home'),
                  _buildMenuItem(context: context, icon: LineIcons.list, title: 'Watchlist', route: '/watchlist'),
                  _buildMenuItem(context: context, icon: LineIcons.bookOpen, title: 'Learning', route: '/learning'),
                ],
              ),
            ),
            _buildLogoutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state == "") {}
      },
      builder: (context, state) {
        String userName = "Guest";
        if (state is AppUserLoggedIn) {
          userName = state.user.name;
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: const BoxDecoration(color: AppPallete.accentColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(LineIcons.user, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(
                        userName,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(LineIcons.alternateExchange, color: Colors.white),
                  SizedBox(width: 8),
                  Text('NextTrade',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppPallete.iconColor, size: 22),
      title: Text(title, style: const TextStyle(color: AppPallete.textColor, fontSize: 16)),
      dense: true,
      onTap: () {
        context.go(route);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Divider(color: AppPallete.dividerColor, height: 1),
          ListTile(
            leading: const Icon(LineIcons.alternateSignOut, color: AppPallete.dangerColor, size: 22),
            title: const Text('Log out', style: TextStyle(color: AppPallete.dangerColor, fontSize: 16)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Log out'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        context.go('/login');
                      },
                      child: const Text('Log out'),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('App Version 1.0.3', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
