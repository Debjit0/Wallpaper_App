import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_application/utils%20/convertUrlToFile.dart';

class ApplyWallpaperProvider extends ChangeNotifier {
  String _message = "";
  bool _status = false;

  String get message => _message;
  bool get status => _status;

  void apply(String? image, int? location, String? path) async {
    _status = true;
    notifyListeners();

    try {
      final file = await converUrlToFile(image!);
      await WallpaperManager.setWallpaperFromFile(file.path, location!);
      _status = false;
      _message = "Applied";
      notifyListeners();
    } catch (e) {
      print(e);
      _status = false;
      _message = "Error Occured";
    }
  }

  void clearMessage() {
    _message = "";
    notifyListeners();
  }
}
