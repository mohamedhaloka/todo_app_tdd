import 'package:dartz/dartz.dart';
import 'package:todo_app_tdd/core/error/exceptions.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/add_task/domain/repositiory/add_task_repository.dart';

class AddTaskRepositoryImpl implements AddTaskRepository {
  final AddTasksLocalDataSource? localSource;
  const AddTaskRepositoryImpl({this.localSource});

  @override
  Future<Either<Failure, TaskEntity>> addTask(TaskEntity task) async {
    try {
      final taskParam = TaskModel(
          title: task.title,
          description: task.description,
          dateTime: task.dateTime,
          views: task.views,
          isDone: task.isDone);
      final taskModel = await localSource!.addTask(taskParam);
      return Right(taskModel);
    } on CacheException {
      return const Left(CacheFailure(errorAddTask));
    }
  }
}

const String errorAddTask = 'Error When add new Task';
