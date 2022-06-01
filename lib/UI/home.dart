import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo_app/DBProvider/db_provider.dart';
import 'package:todo_app/Model/task.dart';
import 'package:todo_app/UI/Widget/create_todo_field.dart';
import 'package:todo_app/UI/alltodo.dart';
import 'package:todo_app/UI/complete.dart';
import 'package:todo_app/UI/imcomplete.dart';
import 'package:todo_app/Utils/mystring.dart';
import 'package:todo_app/Utils/stringformat.dart';
import 'package:todo_app/Utils/toast.dart';
import 'package:todo_app/getX/mycontroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; //current index of page
  String initTextEdit = '';
  TextEditingController? controller;
  final formatString = StringFormat();
  final controllerGetX = Get.put(MyGetXController());

  List<Widget> children = [
    const AllToDoPage(),
    const CompleteToDoPage(),
    const ImCompleteToDoPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initState');
    controller = TextEditingController(text: initTextEdit);
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose');
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didupdatewidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didchangedependencies');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: children[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex, //New
        onTap: onItemTapped,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_off_outlined),
            label: 'Imcomplete`',
          ),
        ],
      ),
    );
  }

 
}
