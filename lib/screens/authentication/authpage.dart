import 'package:flutter/material.dart';
import 'package:wallpaper_application/provider/authProvider.dart';
import 'package:wallpaper_application/screens/mainActivity.dart';
import 'package:wallpaper_application/utils%20/routers.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("Continue with Google"),
        onPressed: () {
          AuthenticationProvider().signInWithGoogle().then((value) {
            nextPageOnly(page: MainActivityPage(), context: context);
          }).catchError((e) {
            showAlert(context, e.toString());
          });
        },
      )),
    );
  }
}
