import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikedImageProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void save({required String? wallpaperImage}) async {
    CollectionReference _products = _firestore.collection("LikedWallpaper");

    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      //upload preview Image
      //add the dwnld url and other data to cloud firestore
      Map<String, dynamic> data = <String, dynamic>{
        "price": "",
        "uid": uid,
        "wallpaperImage": wallpaperImage,
      };
      //this will add data to the collection
      _products.doc(uid).collection("Wallpaper").add(data);
    } catch (e) {
      print(e);
    }
  }

  /*void delete() async {

    _firestore.instance.collection('Wallpaper').delete();
  }*/
}
