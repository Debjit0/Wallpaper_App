import 'package:flutter/material.dart';
import 'package:wallpaper_application/constants/projectColors.dart';
import 'package:wallpaper_application/provider/authProvider.dart';
import 'package:wallpaper_application/screens/mainActivity.dart';
import 'package:wallpaper_application/utils%20/routers.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/login2.svg",
            height: 300,
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            "Continue With Google",
            style: TextStyle(
                color: textColor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/google.png",
              height: 40,
            ),
            onPressed: () {
              AuthenticationProvider().signInWithGoogle().then((value) {
                nextPageOnly(page: MainActivityPage(), context: context);
              }).catchError((e) {
                showAlert(context, e.toString());
              });
            },
          ),
        ],
      )),
    );
  }
}
