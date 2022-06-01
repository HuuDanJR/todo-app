import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/DBProvider/db_provider.dart';
import 'package:todo_app/Model/task.dart';
import 'package:todo_app/UI/Widget/text.dart';
import 'package:todo_app/Utils/mycolor.dart';
import 'package:todo_app/Utils/mystring.dart';
import 'package:todo_app/Utils/stringformat.dart';
import 'package:todo_app/Utils/toast.dart';
import 'package:todo_app/getX/mycontroller.dart';

class ItemToDo_ extends StatefulWidget {
  Color? color;
  double width;
  Function onPressCheckBox;
  Function onPressUpdate;
  Function onPressDelete;
  String text;
  int idKey;
  String date;
  String? textTask;
  bool? isCheck;
  String textId;
  ItemToDo_({
    this.color,
    required this.idKey,
    required this.isCheck,
    required this.onPressCheckBox,
    required this.text,
    required this.textId,
    required this.date,
    required this.width,
    required this.onPressDelete,
    required this.onPressUpdate,
    this.textTask,
  });

  @override
  State<ItemToDo_> createState() => _ItemToDo_State();
}

class _ItemToDo_State extends State<ItemToDo_> {
  final controllerGetX = Get.find<MyGetXController>();
  final formatString = StringFormat();
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isCheck = widget.isCheck!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: widget.width,
      decoration: BoxDecoration(
        color:isCheck == false ? widget.color!.withOpacity(0.5) : widget.color!,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Slidable(
        direction: Axis.horizontal,
        enabled: true,
        useTextDirection: true,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                controllerGetX.saveTaskValue(widget.textTask.toString(),
                widget.idKey.toString(), isCheck);
              },
              backgroundColor: MyColor.blue,
              foregroundColor: Colors.white,
              icon: Icons.system_update_alt,
              label: 'update',
            ),
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                widget.onPressDelete();
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.center,
                width: widget.width * (1 / 10),
                child: textCustom(
                  color: isCheck == false
                      ? MyColor.black_text.withOpacity(0.9)
                      : Colors.black,
                  fontSize: 14,
                  isBold: false,
                  text: widget.textId,
                )),
            Container(
              padding: const EdgeInsets.all(7.5),
              width: widget.width * (8 / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textCustom(
                    color: isCheck == false
                        ? MyColor.black_text.withOpacity(0.9)
                        : Colors.black,
                    fontSize: 13,
                    isBold: false,
                    text: widget.text,
                  ),
                  const SizedBox(height:2.5),
                  textCustom(
                      color: MyColor.grey,
                      fontSize: 10.5,
                      isBold: false,
                      text: (widget.date)
                    )
                ],
              ),
            ),
            Container(
                width: widget.width * (1 / 10),
                child: Checkbox(
                    value: isCheck,
                    onChanged: (value) {
                      widget.onPressUpdate(value);
                      setState(() {
                        isCheck = !isCheck;
                      });
                    }))
          ],
        ),
      ),
    );
  }
}
