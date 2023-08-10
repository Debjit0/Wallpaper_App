import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_application/provider/applyWallpaperProvider.dart';
import 'package:wallpaper_application/provider/likedWallpaperProvider.dart';
import 'package:wallpaper_application/screens/mainActivity.dart';
import 'package:wallpaper_application/utils%20/routers.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';
import 'package:upi_india/upi_india.dart';

class ViewWallpaperPage extends StatefulWidget {
  const ViewWallpaperPage({super.key, this.data, this.path = "", this.id});

  final QueryDocumentSnapshot<Object?>? data;
  final String? path;
  final String? id;
  @override
  State<ViewWallpaperPage> createState() => _ViewWallpaperPageState();
}

class _ViewWallpaperPageState extends State<ViewWallpaperPage> {
  Color favIconColor = Colors.white;
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController amtController = TextEditingController();

  Future<UpiResponse> initiateTransaction(UpiApp app, String upi) async {
    print("$upi ${amtController.text}");
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: upi,
      receiverName: 'Debjit',
      transactionRefId: 'wallAppTest',
      transactionNote: 'Development Phase :)',
      amount: double.parse(amtController.text),
    );
  }

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
        actions: [
          IconButton(
              onPressed: () {
                delete(widget.id, uid);
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    //color: Color.fromARGB(255, 212, 38, 38),
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.data!.get("wallpaperImage")),
                        fit: BoxFit.cover)),
                width: 350,
                height: 500,
                //color: Colors.yellow,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter the amount you want to donate",
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
                controller: amtController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    //side: BorderSide(color: Colors.red)
                  ))),
                  onPressed: () {
                    //print(widget.data!.get("upiId"));
                    initiateTransaction(app, widget.data!.get('upiId'));
                  },
                  child: Text("Donate the uploader")),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                List<String> applyText = [
                  "Home Screen",
                  "Lock Screen",
                  "Both"
                ];
                showModalBottomSheet(
                    backgroundColor: Color.fromARGB(255, 24, 24, 24),
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
                                  child: Text(
                                    applyProvider.status == true
                                        ? "Please Wait"
                                        : "Apply Wallpaper",
                                    style: TextStyle(color: Colors.amber),
                                  ),
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
                                    margin: EdgeInsets.only(
                                        bottom: 15, left: 25, right: 25),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        //color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      applyText[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(25)),
                    child: IconButton(
                        onPressed: () {
                          LikedWallpaperProvider().save(
                              wallpaperImage:
                                  widget.data!.get("wallpaperImage"));
                          setState(() {
                            if (favIconColor == Colors.white) {
                              favIconColor = Colors.red;
                            } else {
                              favIconColor = Colors.white;
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
            )
          ],
        ),
      ),
    );
  }

  void delete(String? id, String? uid) async {
    if (widget.data!.get("uid") == uid) {
      log("case1");
      print(uid);
      print(id);

      await FirebaseFirestore.instance
          .collection("All Wallpaper")
          .doc(id)
          .delete();

      nextPageOnly(context: context, page: MainActivityPage());
      setState(() {});
    } else {
      print("case2");
      showAlert(context, "Not Allowed");
    }
  }
}
