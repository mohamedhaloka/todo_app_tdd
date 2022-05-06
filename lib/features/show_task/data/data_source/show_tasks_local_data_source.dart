import 'package:todo_app_tdd/core/services/db.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';

abstract class ShowTaskLocalDataSource {
  Future<List<TaskModel>?> getAllTasks();

  Future<TaskEntity> deleteTask(TaskEntity task);

  Future<TaskEntity> updateTask(TaskEntity task);
}

class ShowTaskLocalDataSourceImpl implements ShowTaskLocalDataSource {
  final DbService _dbService;
  const ShowTaskLocalDataSourceImpl(this._dbService);

  @override
  Future<List<TaskModel>?> getAllTasks() async {
    final result = await _dbService.allItems() ?? [];
    return List<TaskModel>.from(result.map((item) => TaskModel.fromJson(item)));
  }

  @override
  Future<TaskEntity> deleteTask(TaskEntity task) async {
    await _dbService.deleteItem(task.id!);
    return task;
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    TaskModel taskModel = TaskModel(
        id: task.id,
        isDone: task.isDone,
        title: task.title,
        dateTime: task.dateTime,
        description: task.description,
        views: task.views);
    await _dbService.updateItem(taskModel);
    return task;
  }
}
