import 'package:flutter/material.dart';

Widget textCustom({String? text,double? fontSize,bool? isBold = false, Color? color}) {
  return Text(text!,style:TextStyle(fontSize: fontSize,fontWeight: isBold == false  ? FontWeight.normal : FontWeight.bold,color:color));
}
