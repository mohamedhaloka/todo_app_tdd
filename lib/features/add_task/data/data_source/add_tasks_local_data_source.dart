import 'package:todo_app_tdd/core/error/exceptions.dart';
import 'package:todo_app_tdd/core/services/db.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';

abstract class AddTasksLocalDataSource {
  Future<TaskModel> addTask(TaskModel task);
}

class AddTasksLocalDataSourceImpl implements AddTasksLocalDataSource {
  final DbService _dbService;
  const AddTasksLocalDataSourceImpl(this._dbService);

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      await _dbService.createItem(task);
      return task;
    } catch (e) {
      throw CacheException();
    }
  }
}
