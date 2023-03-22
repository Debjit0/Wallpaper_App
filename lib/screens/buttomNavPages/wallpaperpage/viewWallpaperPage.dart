import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_application/provider/likedWallpaperProvider.dart';

class ViewWallpaperPage extends StatefulWidget {
  const ViewWallpaperPage({super.key, this.data});

  final QueryDocumentSnapshot<Object?>? data;

  @override
  State<ViewWallpaperPage> createState() => _ViewWallpaperPageState();
}

class _ViewWallpaperPageState extends State<ViewWallpaperPage> {
  Color favIconColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("View"),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            widget.data!.get("wallpaperImage"),
            fit: BoxFit.cover,
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
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (() {}),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Text("Apply"),
                              ),
                            ),
                            ...List.generate(applyText.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 5),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(applyText[index]),
                              );
                            })
                          ],
                        ),
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
                          LikedWallpaperProvider().addLikedWallpaper(
                              wallpaperImage:
                                  widget.data!.get("WallpaperImage"));
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
