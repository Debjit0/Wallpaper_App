import 'package:cloud_firestore/cloud_firestore.dart';

class LikedWallpaperProvider {
  // ignore: prefer_final_fields
  CollectionReference _products =
      FirebaseFirestore.instance.collection("Liked Wallpaper");
  addLikedWallpaper(String? wallpaperImage, String? uid) {
    final data = {"wallpaperImage": wallpaperImage, "uid": uid};
    _products.add(data);
  }
}
