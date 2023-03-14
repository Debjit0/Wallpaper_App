import 'package:flutter/material.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/addWallpaper.dart';
import 'package:wallpaper_application/utils%20/routers.dart';

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({super.key});

  @override
  State<WallpaperHomePage> createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All Wallpaper"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () => nextPage(context: context, page: AddWallpaperPage()),
      ),
    );
  }
}
