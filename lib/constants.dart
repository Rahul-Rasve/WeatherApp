// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const yellowColor = Color(0xFFFFE143);
const blackColor = Colors.black;

//input search field decoration
InputDecoration inputDecor({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(
      Icons.search_rounded,
      color: blackColor,
      size: 35.0,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.0),
      borderSide: BorderSide(
        color: blackColor,
        width: 4.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.0),
      borderSide: BorderSide(
        color: blackColor,
        width: 2.0,
      ),
    ),
  );
}
