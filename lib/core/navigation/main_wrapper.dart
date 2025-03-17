import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/theme/app_pallete.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  void initState() {
    super.initState();
    _selectedIndex = widget.navigationShell.currentIndex;
  }

  bool _shouldShowNavBar(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    // print("${GoRouterState.of(context).extra}");
    // print("${GoRouterState.of(context).fullPath}");
    // print("${GoRouterState.of(context).error}");
    // print("${GoRouterState.of(context).pageKey}");
    // print("${GoRouterState.of(context).path}");
    // print("${GoRouterState.of(context).pathParameters}");
    // print("${GoRouterState.of(context).uri}");
    // Add conditions for routes where navigation should be hidden
    // print("Location: $location");
    return !location.endsWith('/editportfolio');
    // return !location.contains('/editprofile') &&
    // !location.contains('/editpassword') &&
    // !location.endsWith('/editportfolio');
    // return location == '/home' || location == '/search' || location == '/portfolio' || location == '/profile';
  }

  void goBranch(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final showNavBar = _shouldShowNavBar(context);
    print("SHOWNAVBAR: $showNavBar");

    return Scaffold(
      body: Container(
        // width: double.infinity,
        // height: double.infinity,
        child: widget.navigationShell,
        // clipBehavior: Clip.none,
      ),
      bottomNavigationBar: showNavBar ? Container(
        decoration: BoxDecoration(
          color: AppPallete.navigationbackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: GNav(
                selectedIndex: _selectedIndex, // Use local _selectedIndex
                onTabChange: (index) {
                  goBranch(index);
                },
              gap: 12,
              backgroundColor: AppPallete.navigationbackgroundColor,
              tabBackgroundColor: AppPallete.accentColor.withOpacity(0.2),
              activeColor: AppPallete.accentColor,
              color: AppPallete.textColor.withOpacity(0.6),
              tabBorderRadius: 20,
              rippleColor: AppPallete.accentColor.withOpacity(0.1),
              hoverColor: AppPallete.accentColor.withOpacity(0.05),
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                tabs: _buildNavTabs()
            ),
          ),
        ),
      ) : null
    );
  }


  List<GButton> _buildNavTabs() {
    // final currentIndex = widget.navigationShell.currentIndex;

    return List.generate(4, (index) {
      final isActive = _selectedIndex != index;
      IconData activeIcon;
      IconData inactiveIcon;
      String text;

      switch (index) {
        case 0:
          activeIcon = LineIcons.home; // Active Home Icon 3-3-2025 monday TA SLOT
          inactiveIcon = Icons.home; // Inactive Home Icon (or another variation)
          text = "Home";
          break;
        case 1:
          activeIcon = LineIcons.search; // Active Search Icon
          inactiveIcon = LineIcons.searchDollar; // Inactive Search Icon (or another variation)
          text = "Search";
          break;
        case 2:
          activeIcon = Icons.data_exploration_outlined; // Active Portfolio Icon
          inactiveIcon = Icons.data_exploration; // Inactive Portfolio Icon (can be the same or different)
          text = "Portfolio";
          break;
        case 3:
          activeIcon = LineIcons.user; // Active Profile Icon
          inactiveIcon = CupertinoIcons.profile_circled; // Inactive Profile Icon (or another variation)
          text = "Profile";
          break;
        default:
          activeIcon = Icons.error;
          inactiveIcon = Icons.error_outline;
          text = "Error";
      }

      return GButton(
        icon: isActive ? activeIcon : inactiveIcon,
        text: text,
        padding: isActive ? EdgeInsets.symmetric(vertical: 10, horizontal: 20) :EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      );
    });
  }
}