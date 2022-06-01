import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Model/task.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._privateConstructer();
  static final DBProvider instance = DBProvider._privateConstructer();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  final String kTableName = 'tasks__';

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tasks__.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute('CREATE TABLE $kTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, isCheck TEXT, date TEXT)');
    await db.execute('CREATE TABLE IF NOT EXISTS $kTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT NOT NULL, isCheck TEXT NOT NULL, date TEXT NOT NULL)');
  }

  Future<List<Task>> getAllTasks() async {
    Database db = await instance.database;
    final tasks = await db.query(kTableName, orderBy: 'id');
    List<Task> TaskList =
        tasks.isNotEmpty ? tasks.map((c) => Task.fromMap(c)).toList() : [];
    return TaskList;
  }
  Future<List<Task>> getTasksComplete() async {
    Database db = await instance.database;
    final tasks = await db.query(kTableName, orderBy: 'id', where: "isCheck = ?", whereArgs: ['true'] );
    List<Task> TaskList =  tasks.isNotEmpty ? tasks.map((c) => Task.fromMap(c)).toList() : [];
    return TaskList;
  }
  Future<List<Task>> getTasksImcomplete() async {
    Database db = await instance.database;
    final tasks = await db.query(kTableName, orderBy: 'id', where: "isCheck = ?", whereArgs: ['false'] );
    List<Task> TaskList =  tasks.isNotEmpty ? tasks.map((c) => Task.fromMap(c)).toList() : [];
    return TaskList;
  }

  Future<int> add(Task task) async {
    Database db = await instance.database;
    return await db.insert(kTableName, task.toMap());
  }

  Future<int> update(Task task) async {
    Database db = await instance.database;
    return await db.update(kTableName, task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(kTableName,  where: "id = ?", whereArgs: [id]);
  }
}
