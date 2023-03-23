import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikedWallpaperProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void save({required String? wallpaperImage}) async {
    CollectionReference _products = _firestore.collection("Liked Wallpaper");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "uid": uid,
        "wallpaperImage": wallpaperImage
      };
      _products.doc(uid).collection("Wallpaper").add(data);
    } catch (e) {
      print(e);
    }
  }
}
