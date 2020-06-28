import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wall_pixel/model/wallpaper.dart';
import 'package:wall_pixel/views/imageView.dart';
import 'package:wall_pixel/views/search.dart';
import 'package:wall_pixel/widgets/widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WallpaperModel> wallpaperData = new List();

  TextEditingController searchController = new TextEditingController();

  getTrendingPhotos() async {
    var res = await http.get(
        "https://api.unsplash.com/photos/?client_id=ORZNuuRqUrqkWxApCYP74A255ni0-zUAYujapr7B8fI");

    var data = json.decode(res.body);

    for (var el in data) {
      WallpaperModel wallpaperModel = WallpaperModel(
          id: el["id"],
          userName: el["user"]["name"],
          imageUrl: el["urls"]["regular"]);

      wallpaperData.add(wallpaperModel);
    }
  }

  @override
  void initState() {
    getTrendingPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search an image',
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              query: searchController.text,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              wallpapersList(wallpapers: wallpaperData, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
