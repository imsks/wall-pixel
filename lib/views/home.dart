import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wall_pixel/data/data.dart';
import 'package:wall_pixel/model/categories.dart';
import 'package:wall_pixel/model/wallpaper.dart';
import 'package:wall_pixel/widgets/widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpaperData = new List();

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
    categories = getCategories();

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
                        decoration: InputDecoration(
                            hintText: 'Search an image',
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categoriesName,
                        imageUrl: categories[index].imageUrl,
                      );
                    }),
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

class CategoriesTile extends StatelessWidget {
  final String imageUrl, title;

  CategoriesTile({@required this.imageUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 50,
                fit: BoxFit.cover,
              )),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
