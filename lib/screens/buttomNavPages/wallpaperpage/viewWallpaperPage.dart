import 'dart:async';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_application/provider/applyWallpaperProvider.dart';
import 'package:wallpaper_application/provider/likedWallpaperProvider.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';

class ViewWallpaperPage extends StatefulWidget {
  const ViewWallpaperPage({super.key, this.data, this.path = ""});

  final QueryDocumentSnapshot<Object?>? data;
  final String? path;

  @override
  State<ViewWallpaperPage> createState() => _ViewWallpaperPageState();
}

class _ViewWallpaperPageState extends State<ViewWallpaperPage> {
  Color favIconColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
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
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 550,
              color: Colors.yellow,
              child: Image.network(
                widget.data!.get("wallpaperImage"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                List<String> applyText = ["Home Screen", "Lock Screen", "Both"];
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 250,
                        child: Consumer<ApplyWallpaperProvider>(
                            builder: (context, applyProvider, child) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            if (applyProvider.message != "") {
                              showAlert(context, applyProvider.message);
                              applyProvider.clearMessage();
                              Navigator.pop(context);
                            }
                          });
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (() {}),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(applyProvider.status == true
                                      ? "Please Wait"
                                      : "Apply"),
                                ),
                              ),
                              ...List.generate(applyText.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    final image =
                                        widget.data!.get("wallpaperImage");
                                    print(index);
                                    switch (index) {
                                      case 0:
                                        //Home Screen
                                        applyProvider.apply(
                                          image,
                                          WallpaperManager.HOME_SCREEN,
                                          widget.path,
                                        );
                                        break;
                                      case 1:
                                        //Lock Screen
                                        applyProvider.apply(
                                          image,
                                          WallpaperManager.LOCK_SCREEN,
                                          widget.path,
                                        );
                                        break;
                                      case 2:
                                        //both screen
                                        applyProvider.apply(
                                          image,
                                          WallpaperManager.BOTH_SCREEN,
                                          widget.path,
                                        );
                                        break;
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(applyText[index]),
                                  ),
                                );
                              })
                            ],
                          );
                        }),
                      );
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("Apply"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          LikedWallpaperProvider().save(
                              wallpaperImage:
                                  widget.data!.get("wallpaperImage"));
                          setState(() {
                            if (favIconColor == Colors.black) {
                              favIconColor = Colors.red;
                            } else {
                              favIconColor = Colors.black;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: favIconColor,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
