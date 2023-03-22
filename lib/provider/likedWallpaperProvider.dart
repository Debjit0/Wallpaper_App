import 'package:cloud_firestore/cloud_firestore.dart';

class LikedWallpaperProvider {
  CollectionReference _products =
      FirebaseFirestore.instance.collection("Liked Wallpaper");
  addLikedWallpaper(String? wallpaperImage, String? uid) {
    _products.add(wallpaperImage, uid);
  }
}
