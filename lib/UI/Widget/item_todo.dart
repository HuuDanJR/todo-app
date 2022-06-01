import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo_app/UI/Widget/text.dart';
import 'package:todo_app/Utils/mycolor.dart';
import 'package:todo_app/getX/mycontroller.dart';

Widget itemTodo(
    {double? width,
    double? height,
    String? text,
    String? textId,
    bool? isCheck,
    onPressCheckBox,
    Color? color}) {
  final controllerGetX = Get.put(MyGetXController());

  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    width: width,
    decoration: BoxDecoration(
      color: isCheck == false
          ? color!.withOpacity(0.15)
          : color!.withOpacity(0.75),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            alignment: Alignment.center,
            width: width! * (1 / 10),
            child: textCustom(
              color: isCheck == false
                  ? MyColor.black_text.withOpacity(0.9)
                  : Colors.black,
              fontSize: 14,
              isBold: false,
              text: textId,
            )),
        Container(
          padding: const EdgeInsets.all(7.5),
          width: width * (8 / 10),
          child: textCustom(
            color: isCheck == false
                ? MyColor.black_text.withOpacity(0.9)
                : Colors.black,
            fontSize: 12,
            isBold: false,
            text: text,
          ),
        ),
        
        SizedBox(
          width: width * (1 / 10),
          child: GetBuilder<MyGetXController>(
            builder: (controller) {
              return Checkbox(
                  value: controller.isCheck.value,
                  onChanged: (value) {
                    debugPrint('item: ${value.toString()}');
                    controller.isCheck.value = !controller.isCheck.value;
                    onPressCheckBox(value);
                  });
            },
          ),
        )
      ],
    ),
  );
}
