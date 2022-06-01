class Task {
  final int? id;
  final String task;
  final String isCheck;
  final String date;
  Task({this.id,required this.task,required this.isCheck,required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isCheck': isCheck,
      'date':date.toString(),
    };
  }
   factory Task.fromMap(Map<String, dynamic> json) =>  Task(
        id: json['id'] ?? 0,
        task: json['task'] ?? '',
        isCheck: json['isCheck'] ?? 'false',
        date: json['date'] ??'',
      );

}
