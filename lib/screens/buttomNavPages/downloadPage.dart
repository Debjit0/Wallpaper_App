import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewWallpaperPage.dart';

import '../../utils /routers.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final CollectionReference wallpaper =
      FirebaseFirestore.instance.collection("Liked Wallpaper");

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: wallpaper.doc(uid).collection('Wallpaper').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No Wallpaper"),
              );
            } else {
              final data = snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.6,
                  children: List.generate(data.length, (index) {
                    final image = data[index];
                    return GestureDetector(
                      onTap: (() {
                        nextPage(
                            context: context,
                            page: ViewWallpaperPage(
                              data: image,
                            ));
                      }),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(image.get("wallpaperImage")))),
                        /*child: Center(
                            child: image.get('price') == ''
                                ? const Text("")
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Text(image.get('price')),
                                  )),*/
                      ),
                    );
                  }),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
