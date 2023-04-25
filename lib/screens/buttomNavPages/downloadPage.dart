import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewLikedWallpaper.dart';
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

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LiquidPullToRefresh(
        height: 200,
        animSpeedFactor: 2,
        onRefresh: _handleRefresh,
        child: FutureBuilder(
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
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.8,
                    children: List.generate(data.length, (index) {
                      final image = data[index];
                      return GestureDetector(
                        onTap: (() {
                          nextPage(
                              context: context,
                              page: ViewLikedWallpaperPage(
                                data: image,
                              ));
                        }),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      image.get("wallpaperImage")))),
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
      ),
    );
  }
}
