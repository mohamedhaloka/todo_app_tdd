import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? title, description, dateTime;
  int? views, isDone;
  TaskEntity(
      {this.title,
      this.description,
      this.dateTime,
      this.isDone,
      this.views,
      this.id});

  @override
  List<Object?> get props => [
        title,
        description,
        dateTime,
        isDone,
        views,
      ];
}
