import 'package:flutter/material.dart';

Widget spaceHeight(double height) => SizedBox(
      height: height,
    );
Widget bottomContainers(child) => Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
