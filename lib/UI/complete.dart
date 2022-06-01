import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_app/DBProvider/db_provider.dart';
import 'package:todo_app/Model/task.dart';
import 'package:todo_app/UI/Widget/item_todo_.dart';
import 'package:todo_app/UI/Widget/myprogressindicator.dart';
import 'package:todo_app/UI/Widget/text.dart';
import 'package:todo_app/Utils/mycolor.dart';
import 'package:todo_app/Utils/mystring.dart';
import 'package:todo_app/Utils/stringformat.dart';
import 'package:todo_app/Utils/toast.dart';
import 'package:todo_app/getX/mycontroller.dart';

class CompleteToDoPage extends StatefulWidget {
  const CompleteToDoPage({Key? key}) : super(key: key);

  @override
  State<CompleteToDoPage> createState() => _CompleteToDoPageState();
}

class _CompleteToDoPageState extends State<CompleteToDoPage> {
  final formatString = StringFormat();
  final controllerGetX = Get.put(MyGetXController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final paddingValue = 16.0;
    return SafeArea(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: paddingValue),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textCustom(
                  color: MyColor.black_text,
                  fontSize: 16,
                  isBold: false,
                  text: MyString.page_complete_title),
              const SizedBox(height: 10),
              Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: DBProvider.instance.getTasksComplete(),
                    builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                      final listTask = snapshot.data;
                      if (!snapshot.hasData) {
                        return myprogresscircular();
                      }
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: textCustom(
                                  color: MyColor.black_text,
                                  fontSize: 12,
                                  isBold: false,
                                  text: MyString.label_todo_complete))
                          : ListView.builder(
                              itemCount: listTask?.length,
                              itemBuilder: (context, index) {
                                return ItemToDo_(
                                  date: listTask![index].date,
                                  onPressDelete: () async {
                                    debugPrint('onpress delte');
                                    await DBProvider.instance
                                        .remove(listTask[index].id!)
                                        .then((value) {
                                      setState(() {});
                                      controllerGetX.resetTaskValue();
                                      showToast(MyString.label_toast_delete);
                                    });
                                  },
                                  onPressUpdate: (value) async {
                                    debugPrint('onPress update');
                                    if (value == false) {
                                      await DBProvider.instance.update(Task(
                                          id: listTask[index].id!,
                                          task: listTask[index].task,
                                          isCheck: 'false',
                                          date: formatString.formatDateAndTime(
                                              DateTime.now())));
                                      setState(() {
                                        
                                      });
                                    } else {
                                      await DBProvider.instance.update(Task(
                                          id: listTask[index].id,
                                          task: listTask[index].task,
                                          isCheck: 'true',
                                          date: formatString.formatDateAndTime(
                                              DateTime.now())));
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  idKey: listTask[index].id!,
                                  textTask: listTask[index].task,
                                  isCheck: listTask[index].isCheck == 'false'
                                      ? false
                                      : true,
                                  onPressCheckBox: (value) {
                                    debugPrint(value.toString());
                                  },
                                  textId: (index + 1).toString(),
                                  color: MyColor.grey_tab,
                                  text: listTask[index].task,
                                  width: width - (paddingValue * 2),
                                );
                              },
                            );
                    },
                  ))
            ],
          )),
    );
  }
}
