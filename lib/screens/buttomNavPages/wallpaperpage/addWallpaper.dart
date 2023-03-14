import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/provider/wallpaperProvider.dart';
import 'package:wallpaper_application/utils%20/pickImage.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';

class AddWallpaperPage extends StatefulWidget {
  const AddWallpaperPage({super.key});

  @override
  State<AddWallpaperPage> createState() => _AddWallpaperPageState();
}

class _AddWallpaperPageState extends State<AddWallpaperPage> {
  TextEditingController? controller;
  String image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Wallpaper")),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    /*TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        label: Text("Enter Price (Optional)"),
                        border: OutlineInputBorder(),
                      ),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (() {
                        pickImage().then((value) {
                          setState(() {
                            image = value;
                          });
                        });
                      }),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.camera),
                      ),
                    ),
                    if (image != '') Image.file(File(image)),
                    Consumer<UploadWallpaperProvider>(
                        builder: (context, add, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (add.message != '') {
                          showAlert(context, add.message);
                          add.clear();
                        }
                      });
                      return ElevatedButton(
                          onPressed: add.status == true
                              ? null
                              : () {
                                  final uid =
                                      FirebaseAuth.instance.currentUser!.uid;

                                  if (image != "") {
                                    add.addWallpaper(
                                        wallpaperImage: File(image),
                                        uid: uid,
                                        price: controller.toString());
                                  } else {
                                    showAlert(context, "Upload Image");
                                  }
                                },
                          child: Text("Upload"));
                    }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
