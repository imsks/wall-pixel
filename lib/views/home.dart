import 'package:flutter/material.dart';
import 'package:wall_pixel/widgets/widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Search an image'),
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ) 
          ],
        ),
      ),
    );
  }
}
