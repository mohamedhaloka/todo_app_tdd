import 'package:dartz/dartz.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';

abstract class AddTaskRepository {
  Future<Either<Failure, TaskEntity>> addTask(TaskEntity task);
}
