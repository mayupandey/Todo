import 'package:flutter/material.dart';

const collectionName = "todos";
const appBarText = "Hello, I'm";
const modalSheetTitle = "Add New Todo";

TextStyle greyText = const TextStyle(color: Colors.grey, fontSize: 14);
Color white = Colors.white;
Color grey = Colors.grey;

TextStyle headingBlackText = const TextStyle(
    fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black);

InputDecoration bottomSheet(title) => InputDecoration(
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    hintText: title);

TextStyle headingBLueText = const TextStyle(
    color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 18);
TextStyle headingWhiteText = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}