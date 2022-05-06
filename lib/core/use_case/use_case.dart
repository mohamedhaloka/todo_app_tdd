import 'package:dartz/dartz.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import '../error/failure.dart';

abstract class UseCase<Out, Params> {
  Future<Either<Failure, Out>> call(Params params);
}

class AddTaskParam {
  final TaskEntity? taskEntity;
  AddTaskParam(this.taskEntity);
}

class NoParams {}

class TaskParams{
  final TaskEntity? taskEntity;
  const TaskParams({this.taskEntity});
}
