import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/DBProvider/db_provider.dart';
import 'package:todo_app/Model/task.dart';
import 'package:todo_app/main.dart' as app;

final result = DBProvider.instance.getAllTasks().then((value) {
  value = listTask;
});
final List<Task> listTask = [];

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final List<Task> listTask;
  checkTask(Task task) {
    if (task.task.isNotEmpty) {
      return true;
    }
  }

  checkAllListTodoExist() async {
    final List<Task> listTask = [];
    await DBProvider.instance.getAllTasks().then((value) {
      value = listTask;
    });
    debugPrint('${listTask.length}');
    return listTask.length;
  }

   addTodo(Task task) async {
    return await DBProvider.instance.add(task).then((value) {
       
    });
    
  }

  test('test list todo task test', () {
    expect(true, checkTask(Task(task: '0', isCheck: 'false', date: '')));
  });
  test('test add new todo', () {
    expect([],
        addTodo(Task(task: '0', isCheck: 'false', date: '2020-02-02')));
  });
  // test('test list todo', () {
  //   expect(0, checkAllListTodoExist());
  // });
}
