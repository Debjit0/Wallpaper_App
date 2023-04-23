//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_application/utils%20/showAlert.dart';

class MyUploadsProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void save({required String? wallpaperImage}) async {
    CollectionReference _products = _firestore.collection("Uploads");
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      Map<String, dynamic> data = <String, dynamic>{
        "uid": uid,
        "wallpaperImage": wallpaperImage
      };
      _products.doc(uid).set(data);
    } catch (e) {
      print(e.toString());
    }
  }
}
