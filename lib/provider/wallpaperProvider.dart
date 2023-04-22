import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadWallpaperProvider extends ChangeNotifier {
  String _message = "";
  bool _status = false;
  String get message => _message;
  bool get status => _status;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  void clear() {
    _message = "";
  }

  void addWallpaper({
    File? wallpaperImage,
    String? uid,
    String? price,
    String? upiId,
  }) async {
    _status = true;
    notifyListeners();

    CollectionReference _products = _firestore.collection("All Wallpaper");
    CollectionReference _products2 = _firestore.collection("My Uploads");
    String imagePath = '';
    try {
      _message = "Uploading Image";
      notifyListeners();

      final imageName = wallpaperImage!.path.split('/').last;
      await _storage
          .ref()
          .child("$uid/Wallpaper/$imageName")
          .putFile(wallpaperImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child("$uid/Wallpaper/$imageName")
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });
        final data = {
          'price': price,
          'uid': uid,
          'wallpaperImage': imagePath,
          'upiId': upiId,
        };

        await _products.add(data);
        await _products2.doc(uid).collection("My Wallpaper").add(data);
        _status = false;
        _message = 'Successful';
      });
    } on FirebaseException catch (e) {
      _status = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (_) {
      _status = false;
      _message = "Internet Required";
      notifyListeners();
    } catch (e) {
      _status = false;
      _message = "Try Again";
      notifyListeners();
    }
  }
}
