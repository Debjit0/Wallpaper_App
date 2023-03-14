import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallpaper_application/utils%20/pickImage.dart';

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
                    TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        label: Text("Enter Price (Optional)"),
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                    ElevatedButton(onPressed: () {}, child: Text("Upload")),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
