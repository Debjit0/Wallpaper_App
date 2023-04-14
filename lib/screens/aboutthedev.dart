import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
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
              "Debjit Sarkar",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(
              "Meet Debjit, an Android developer with 2 years of experience, and passion in building apps for various industries. He has a strong grasp of Java and Flutter and enjoys solving complex problems. Debjit stays up to date with the latest technologies and is passionate about creating user-friendly and efficient apps.",
              style: TextStyle(color: Colors.grey, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Container(
            child: Text(
              "Connect With Me",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.link_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "instagram.com/debjit.mp3/",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.link_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "linkedin.com/in/debjit-sarkar-20913b1b3/",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.link_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "debjitfirstname@icloud.com",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
