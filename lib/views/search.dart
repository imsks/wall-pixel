import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:wall_pixel/model/wallpaper.dart';
import 'package:wall_pixel/widgets/widget.dart';

class Search extends StatefulWidget {

  final String query;

  Search({this.query});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<WallpaperModel> wallpaperData = new List();

  TextEditingController searchController = new TextEditingController();

  getSearchPhotos(query) async {
    // wallpaperData = null;
    wallpaperData.clear();
    
    var res = await http.get(
        "https://api.unsplash.com/search/photos/?client_id=ORZNuuRqUrqkWxApCYP74A255ni0-zUAYujapr7B8fI&query=$query");

    var data = json.decode(res.body);

    for (var el in data["results"]) {
      WallpaperModel wallpaperModel = WallpaperModel(
          id: el["id"],
          userName: el["user"]["name"],
          imageUrl: el["urls"]["regular"]);

      wallpaperData.add(wallpaperModel);
    }
  }

  @override
  void initState() {
    super.initState();
    getSearchPhotos(widget.query);
    searchController.text = widget.query;
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
                            hintText: "Search a photo",
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                      onTap: () {
                        getSearchPhotos(searchController.text);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpaperData, context: context)
            ],
          ),
        ),
      ),
    );
  }
}