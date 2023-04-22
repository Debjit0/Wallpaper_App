import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wallpaper_application/constants/projectColors.dart';

class MyUploads extends StatefulWidget {
  const MyUploads({super.key});

  @override
  State<MyUploads> createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(
          'My Uploads',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
        ),
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/appbarbg2.jpeg"),
                  fit: BoxFit.cover)),
        ),
        elevation: 5,
        centerTitle: true,
      ),
    );
  }
}
