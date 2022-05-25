import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle() {
    return TextStyle(
      letterSpacing: 1.0,
      color: Colors.grey[300],
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    );
  }

  static TextStyle lightTextFeildStyle() {
    return TextStyle(
      color: Colors.white54,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );
  }

  static Widget createButton(String name) {
    return Container(
      padding: EdgeInsets.all(13),
      width: 400,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 184, 166, 6),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
          child: Text(
        name,
        style: AppWidget.boldTextFeildStyle(),
      )),
    );
  }

  static Widget createColortext(String name) {
    return Text(
      name,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  static Widget shortButton(String name) {
    return Container(
        width: 110,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  static TextStyle blackcolorboldFeildStyle() {
    return TextStyle(
        color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 20.0);
  }
}
