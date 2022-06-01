import 'package:flutter/material.dart';
import 'package:todo_app/Utils/mycolor.dart';
import 'package:todo_app/Utils/mystring.dart';

Widget creatToDoField({width, TextEditingController? controller, onPress,String? buttonText}) {
  // final isDisplayButton = false;
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: MyColor.grey_tab,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: width * 3 / 4,
            child: TextField(
              // onChanged: (value) {
              //   if (value.isNotEmpty) {}
              // },
              decoration: InputDecoration.collapsed(
                  hintText: MyString.label_todo_hint,
                  hintStyle: const TextStyle(
                    fontSize: 12,
                  )),
              controller: controller,
            )),
        SizedBox(
          width: width * 1 / 4,
          child: TextButton(
              onPressed: () {
                // if (controller!.text.isNotEmpty) {
                //   onPress();
                // }
                 onPress();
              },
              child: Text(buttonText!)),
        )
      ],
    ),
  );
}
