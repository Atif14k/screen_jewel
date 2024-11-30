import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({super.key, required this.imageurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    final String result =
        (await WallpaperManager.setWallpaperFromFile(file.path, location))
            as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: Container(
            child: Image.network(widget.imageurl),
          )),
          InkWell(
            onTap: () {
              setwallpaper();
            },
            child: Container(
                height: 30,
                width: double.infinity,
                // padding: EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: const Center(child: Text("Set Wallpaper"))),
          )
        ],
      )),
    );
  }
}
