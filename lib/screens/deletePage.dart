import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wallpaper_application/constants/projectColors.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key, this.data, this.path = "", this.id, this.uid});

  final QueryDocumentSnapshot<Object?>? data;
  final String path;
  final String? id;
  final String? uid;
  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          title: Text(
            'View Wallpaper',
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
        body: Column(
          children: [
            Container(
                child: Image.network(
              widget.data!.get("wallpaperImage"),
            )),
            ElevatedButton(
                onPressed: () {
                  deleteWallpaper(widget.id, widget.uid);
                },
                child: Text("Delete")),
          ],
        ));
  }

  void deleteWallpaper(String? id, String? uid) async {
    print(uid);
    print(id);

/*
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(FirebaseFirestore.instance
          .collection("My Uploads")
          .doc(uid)
          .collection("My Wallpaper")
          .doc(id));
    });
*/

    try {
      await FirebaseFirestore.instance
          .collection("My Uploads")
          .doc(uid)
          .collection("My Wallpaper")
          .doc(id)
          .delete();
      print("delete");
    } catch (e) {
      print(e);
    }
  }
}
