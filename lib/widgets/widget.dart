import 'package:flutter/material.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
      'Wall',
      style: TextStyle(
        color: Colors.black87
      ),
    ),
    Text(
      'Pixel',
      style: TextStyle(
        color: Colors.blue
      ),
    )
  ],);
}