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

class ViewLikedWallpaperPage extends StatefulWidget {
  const ViewLikedWallpaperPage({super.key, this.data, this.path = "", this.id});

  final QueryDocumentSnapshot<Object?>? data;
  final String? path;
  final String? id;
  @override
  State<ViewLikedWallpaperPage> createState() => _ViewLikedWallpaperPageState();
}

class _ViewLikedWallpaperPageState extends State<ViewLikedWallpaperPage> {
  Color favIconColor = Colors.white;
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController amtController = TextEditingController();

  Future<UpiResponse> initiateTransaction(UpiApp app, String upi) async {
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
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: "Enter amount to donate",
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.deepPurple))),
                controller: amtController,
              ),
              ElevatedButton(
                  onPressed: () {
                    //print(widget.data!.get("upiId"));
                    initiateTransaction(app, widget.data!.get('upiId'));
                  },
                  child: Text("Donate the uploader"))
            ],
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                List<String> applyText = ["Home Screen", "Lock Screen", "Both"];
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
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void delete(String? id, String? uid) async {
    if (widget.data!.get("uid") == uid) {
      log(widget.data!.get("uid"));
      print(uid);

      log("case1");

      await FirebaseFirestore.instance
          .collection("Liked Wallpaper")
          .doc(uid)
          .collection("Wallpaper")
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
