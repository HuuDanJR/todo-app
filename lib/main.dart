import 'package:flutter/material.dart';
import 'package:todo_app/UI/alltodo.dart';
import 'package:todo_app/UI/complete.dart';
import 'package:todo_app/UI/home.dart';
import 'package:todo_app/UI/imcomplete.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes:  <String,WidgetBuilder>{
        '/all': (BuildContext context)=>const AllToDoPage(),
        '/complete': (BuildContext context)=>const CompleteToDoPage(),
        '/imcomplete': (BuildContext context)=>const ImCompleteToDoPage(),
      }
    );
  }
}

