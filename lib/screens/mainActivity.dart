import 'package:flutter/material.dart';
import 'package:wallpaper_application/provider/authProvider.dart';
import 'package:wallpaper_application/screens/authentication/authpage.dart';
import 'package:wallpaper_application/screens/buttomNavPages/downloadPage.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewAllWallpaperPage.dart';
import 'package:wallpaper_application/utils%20/routers.dart';

class MainActivityPage extends StatefulWidget {
  const MainActivityPage({super.key});

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  int pageIndex = 0;
  List<Map> bottomNavItems = [
    {'icon': Icons.home, 'title': 'Home'},
    {'icon': Icons.download, 'title': 'Download'},
  ];

  List<Widget> bottomNavPages = [
    const WallpaperHomePage(),
    const DownloadPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallaper"),
        actions: [
          IconButton(
              onPressed: () {
                AuthenticationProvider().signOut().then((value) {
                  nextPageOnly(page: AuthPage(), context: context);
                });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: bottomNavPages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          setState(() {
            pageIndex = value;
          });
        }),
        currentIndex: pageIndex,
        items: List.generate(bottomNavItems.length, (index) {
          final data = bottomNavItems[index];
          return BottomNavigationBarItem(
              icon: Icon(data['icon']), label: data['title']);
        }),
      ),
    );
  }
}
