import 'package:flutter/material.dart';
import 'package:wallpaper_application/screens/authentication/authpage.dart';
import 'package:wallpaper_application/utils%20/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      nextPageOnly(context: context, page: const AuthPage());
    });

    return Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }
}
