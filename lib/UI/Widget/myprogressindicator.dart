import 'package:flutter/material.dart';
import 'package:todo_app/Utils/mycolor.dart';

Widget myprogresscircular() {
  return  Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor:  AlwaysStoppedAnimation<Color>(MyColor.blue),
    ),
  );
}