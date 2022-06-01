import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DBProvider/db_provider.dart';
import 'package:todo_app/Model/task.dart';
import 'package:todo_app/UI/Widget/create_todo_field.dart';
import 'package:todo_app/UI/Widget/item_todo_.dart';
import 'package:todo_app/UI/Widget/myprogressindicator.dart';
import 'package:todo_app/UI/Widget/text.dart';
import 'package:todo_app/Utils/mycolor.dart';
import 'package:todo_app/Utils/mystring.dart';
import 'package:todo_app/Utils/stringformat.dart';
import 'package:todo_app/Utils/toast.dart';
import 'package:todo_app/getX/mycontroller.dart';

class AllToDoPage extends StatefulWidget {
  const AllToDoPage({Key? key}) : super(key: key);

  @override
  State<AllToDoPage> createState() => _AllToDoPageState();
}

class _AllToDoPageState extends State<AllToDoPage> {
  TextEditingController? controller;
  final formatString = StringFormat();
  String initTextEdit = '';
  final controllerGetX = Get.put(MyGetXController());

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose');
  }

  @override
  void didUpdateWidget(covariant AllToDoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didupdatewidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didchangedependencies');
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: initTextEdit);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final paddingValue = 16.0;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
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
                      text: MyString.page_all_title),
                  const SizedBox(height: 10),
                  Expanded(
                      flex: 1,
                      child: GetBuilder<MyGetXController>(
                        builder: (controller) {
                          return FutureBuilder(
                            future: DBProvider.instance.getAllTasks(),
                            builder:
                                (context, AsyncSnapshot<List<Task>> snapshot) {
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
                                          text: MyString.label_todo_all))
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
                                                  setState(() {
                                                    
                                                  });
                                              showToast(MyString.label_toast_delete);
                                            });
                                          },
                                          onPressUpdate: (value) async {
                                            debugPrint('onPress update');
                                            if (value == false) {
                                              await DBProvider.instance.update(
                                                  Task(
                                                      id: listTask[index].id!,
                                                      task:
                                                          listTask[index].task,
                                                      isCheck: 'false',
                                                      date: formatString
                                                          .formatDateAndTime(
                                                              DateTime.now())));
                                            } else {
                                              await DBProvider.instance.update(
                                                  Task(
                                                      id: listTask[index].id,
                                                      task:
                                                          listTask[index].task,
                                                      isCheck: 'true',
                                                      date: formatString
                                                          .formatDateAndTime(
                                                              DateTime.now())));
                                            }
                                          },
                                          idKey: listTask[index].id!,
                                          textTask: listTask[index].task,
                                          isCheck:
                                              listTask[index].isCheck == 'false'
                                                  ? false
                                                  : true,
                                          onPressCheckBox: (value) {
                                            debugPrint(value.toString());
                                          },
                                          textId: (index+1).toString(),
                                          color: MyColor.grey_tab,
                                          text: listTask[index].task,
                                          width: width - (paddingValue * 2),
                                        );
                                      },
                                    );
                            },
                          );
                        },
                      )
                      // ListView(
                      //   padding: const EdgeInsets.all(0),
                      //   shrinkWrap: true,
                      //   children: [
                      //     Obx(
                      //       () => itemTodo(
                      //         onPressCheckBox: (value) {
                      //           debugPrint(value.toString());
                      //         },
                      //         textId: '1',
                      //         color: MyColor.grey_tab,
                      //         text:'eturns a new list, removeDuplicates() does it lazily by returning an Iterable. This means it is much more efficient when you are doing some extra processing. For example, suppose you have a list with a million items, and you want to remove duplicates and get the first five:',
                      //         width: width - (paddingValue * 2),
                      //         isCheck: controllerGetX.isCheck.value,
                      //       ),
                      //     ),
                      //     ItemToDo_(
                      //         isCheck:true,
                      //         onPressCheckBox: (value) {
                      //           debugPrint(value.toString());
                      //         },
                      //         textId: '1',
                      //         color: MyColor.grey_tab,
                      //         text:'eturns a new list, removeDuplicates() does it lazily by returning an Iterable. This means it is much more efficient when you are doing some extra processing. For example, suppose you have a list with a million items, and you want to remove duplicates and get the first five:',
                      //         width: width-(paddingValue*2),
                      //       ),

                      //   ],
                      // ),
                      )
                ],
              )),
          Positioned(
              bottom: 0,
              child: GetBuilder<MyGetXController>(
                builder: (ctl) {
                  if (ctl.task.isNotEmpty && ctl.taskId.isNotEmpty) {
                    controller!.text = ctl.task.value;
                    return creatToDoField(
                        buttonText: MyString.button_update,
                        width: width,
                        controller: controller,
                        onPress: () async {
                          debugPrint('click ${controller!.text}');
                          if (controller!.text.isNotEmpty) {
                            debugPrint('new value: ${controller!.text}');
                            debugPrint('new value id: ${ctl.taskId.value}');
                            await DBProvider.instance
                                .update(Task(
                                    id: int.parse(ctl.taskId.value),
                                    task: controller!.text,
                                    isCheck: ctl.isCheck.value.toString(),
                                    date: formatString
                                        .formatDateAndTime(DateTime.now())))
                                .then((value) {
                              ctl.resetTaskValue();
                              showToast(MyString.label_toast_update);
                            });
                          }
                          clearTextFieldValue();
                        });
                  } else {
                    return creatToDoField(
                        buttonText: MyString.button_create,
                        width: width,
                        controller: controller,
                        onPress: () async {
                          debugPrint('click ${controller!.text}');
                          if (controller!.text.isNotEmpty) {
                            await DBProvider.instance
                                .add(Task(
                                    task: controller!.text,
                                    isCheck: ctl.isCheck.value.toString(),
                                    date: formatString.formatDateAndTime2(DateTime.now())))
                                .then((value) {
                              showToast(MyString.label_toast_add);
                            });
                          }
                          clearTextFieldValue();
                        });
                  }
                },
              )),
        ],
      ),
    ));
  }

  clearTextFieldValue() {
    setState(() {
      controller!.clear();
    });
  }
}
