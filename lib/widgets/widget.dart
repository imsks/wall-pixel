import 'package:flutter/material.dart';
import 'package:wall_pixel/model/wallpaper.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Wall',
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        'Pixel',
        style: TextStyle(color: Colors.blue),
      )
    ],
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: GridView.count(
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                wallpaper.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
