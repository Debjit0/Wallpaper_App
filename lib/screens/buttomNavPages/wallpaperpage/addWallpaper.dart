import 'package:flutter/material.dart';

class AddWallpaperPage extends StatefulWidget {
  const AddWallpaperPage({super.key});

  @override
  State<AddWallpaperPage> createState() => _AddWallpaperPageState();
}

class _AddWallpaperPageState extends State<AddWallpaperPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Add Wallpaper"),
      ),
    );
  }
}
