import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wallpaper_application/constants/projectColors.dart';

import '../utils /routers.dart';
import 'buttomNavPages/wallpaperpage/viewWallpaperPage.dart';
import 'deletePage.dart';

class MyUploads extends StatefulWidget {
  const MyUploads({super.key});

  @override
  State<MyUploads> createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  final CollectionReference wallpaper =
      FirebaseFirestore.instance.collection("My Uploads");

  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(
          'Lifetime Uploads',
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
      body: LiquidPullToRefresh(
        height: 200,
        animSpeedFactor: 2,
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: wallpaper.doc(uid).collection('My Wallpaper').get(),
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
                              page: DeletePage(
                                data: image,
                                id: snapshot.data!.docs[index].id,
                                uid: uid,
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
