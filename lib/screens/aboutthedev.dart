import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallpaper_application/constants/projectColors.dart';

class AboutTheDev extends StatefulWidget {
  const AboutTheDev({super.key});

  @override
  State<AboutTheDev> createState() => _AboutTheDevState();
}

class _AboutTheDevState extends State<AboutTheDev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(
          'Pixilate',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          //circular image
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/demo.jpg"),
            radius: 60,
          ),

          SizedBox(
            height: 20,
          ),
          //Main Text
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Debjit",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
