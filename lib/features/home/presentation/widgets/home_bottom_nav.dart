import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 74,
      selectedIndex: 0,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFEAF4FF),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          selectedIcon: Icon(Icons.description_rounded),
          label: 'Resume',
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article_rounded),
          label: 'Berita',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profil',
        ),
      ],
    );
  }
}
