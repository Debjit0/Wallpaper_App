import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/provider/applyWallpaperProvider.dart';
import 'package:wallpaper_application/provider/wallpaperProvider.dart';
import 'package:wallpaper_application/screens/spashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UploadWallpaperProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ApplyWallpaperProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: SplashPage(),
      ),
    );
  }
}
//testß
