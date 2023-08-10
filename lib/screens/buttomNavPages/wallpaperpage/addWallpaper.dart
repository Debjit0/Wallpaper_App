import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/provider/myUploadsProvider.dart';
import 'package:wallpaper_application/provider/wallpaperProvider.dart';
import 'package:wallpaper_application/screens/mainActivity.dart';
import 'package:wallpaper_application/utils%20/pickImage.dart';
import 'package:wallpaper_application/utils%20/routers.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';

class AddWallpaperPage extends StatefulWidget {
  const AddWallpaperPage({super.key});

  @override
  State<AddWallpaperPage> createState() => _AddWallpaperPageState();
}

class _AddWallpaperPageState extends State<AddWallpaperPage> {
  TextEditingController? controller;
  String image = '';
  TextEditingController upiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Upload Image',
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
                      height: 0,
                    ),

                    image == ""
                        ? GestureDetector(
                            onTap: (() {
                              pickImage().then((value) {
                                setState(() {
                                  image = value;
                                });
                              });
                            }),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 10, 10, 10),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color.fromARGB(255, 63, 63, 63),
                                    size: 50,
                                  ),
                                  Text(
                                    "Click Here To Select Photo",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 63, 63, 63),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: 500,
                            width: 350,
                            decoration: BoxDecoration(
                                //color: Color.fromARGB(255, 212, 38, 38),
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: FileImage(File(image)),
                                    fit: BoxFit.cover)),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter UPI id",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.lightBlue,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        controller: upiController,
                      ),
                    ),
                    SizedBox(height: 20,),
                    /*TextField(
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          hintText: "Enter UPI id",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.deepPurple))),
                      controller: upiController,
                    ),*/
                    //if (image != '') Image.file(File(image)),
                    Consumer<UploadWallpaperProvider>(
                        builder: (context, add, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (add.message != '') {
                          showAlert(context, add.message);
                          add.clear();
                        }
                      });

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red)
                              ))),
                              onPressed: add.status == true
                                  ? null
                                  : () {
                                      final uid = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      if (image != "") {
                                        add.addWallpaper(
                                            wallpaperImage: File(image),
                                            uid: uid,
                                            price: controller.toString(),
                                            upiId: upiController.text);
                                      } else {
                                        showAlert(context, "Upload Image");
                                      }
                                      nextPageOnly(
                                          context: context,
                                          page: MainActivityPage());
                                    },
                              child: Text("Upload")),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
