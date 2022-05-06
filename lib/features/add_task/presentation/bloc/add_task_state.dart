import 'package:equatable/equatable.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';

abstract class AddTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTaskEmpty extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskLoad extends AddTaskState {
  final TaskEntity? task;
  AddTaskLoad({this.task});
}

class AddTaskError extends AddTaskState {
  final String? msg;
  AddTaskError(this.msg);
}
