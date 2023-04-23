import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wallpaper_application/constants/projectColors.dart';
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

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          height: 200,
          animSpeedFactor: 5,
          child: Builder(builder: (context) {
            return FutureBuilder(
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
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8,
                        children: List.generate(data.length, (index) {
                          final image = data[index];
                          return GestureDetector(
                            onTap: (() {
                              nextPage(
                                  context: context,
                                  page: ViewWallpaperPage(
                                    data: image,
                                    id: snapshot.data!.docs[index].id,
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
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () => nextPage(context: context, page: AddWallpaperPage()),
      ),
    );
  }
}
