import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/addWallpaper.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewWallpaperPage.dart';
import 'package:wallpaper_application/utils%20/routers.dart';

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({super.key});

  @override
  State<WallpaperHomePage> createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  final CollectionReference wallpaper =
      FirebaseFirestore.instance.collection("All Wallpaper");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: wallpaper.get(),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () => nextPage(context: context, page: AddWallpaperPage()),
      ),
    );
  }
}
