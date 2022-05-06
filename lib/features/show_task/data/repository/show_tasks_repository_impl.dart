import 'package:dartz/dartz.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/data/data_source/show_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';

class ShowTaskRepositoryImpl implements ShowTaskRepository {
  final ShowTaskLocalDataSource _localSource;
  const ShowTaskRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    final result = await _localSource.getAllTasks();
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetTasks));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> deleteTask(TaskEntity task) async {
    try {
      final result = await _localSource.deleteTask(task);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorRemoveTask));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) async {
    try {
      final result = await _localSource.updateTask(task);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorUpdateTask));
    }
  }
}

const String errorGetTasks = 'Error in get tasks';
const String errorRemoveTask = 'Error in remove task';
const String errorUpdateTask = 'Error in update task';
