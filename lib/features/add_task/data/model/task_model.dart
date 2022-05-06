import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {String? description,
      String? dateTime,
      int? isDone,
      int? id,
      String? title,
      int? views})
      : super(
            dateTime: dateTime,
            description: description,
            isDone: isDone,
            id: id,
            views: views,
            title: title);

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'],
        dateTime: json['dateTime'],
        description: json['description'],
        views: json['views'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'id': id,
        'dateTime': dateTime,
        'isDone': isDone,
        'views': views,
      };
}
