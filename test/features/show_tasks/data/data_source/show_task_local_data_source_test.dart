import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/core/services/db.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/show_task/data/data_source/show_tasks_local_data_source.dart';

class MockDBService extends Mock implements DbService {}

void main() {
  MockDBService? _dbService;
  ShowTaskLocalDataSource? localSource;

  setUp(() {
    _dbService = MockDBService();
    localSource = ShowTaskLocalDataSourceImpl(_dbService!);
  });

  final tasks = [
    TaskModel(title: '', dateTime: '', description: '', views: 0, isDone: 0)
        .toJson(),
    TaskModel(title: '', dateTime: '', description: '', views: 0, isDone: 0)
        .toJson(),
    TaskModel(title: '', dateTime: '', description: '', views: 0, isDone: 0)
        .toJson(),
  ];
  final task = TaskModel(
      title: '', dateTime: '', description: '', views: 0, isDone: 0, id: 0);

  test('should call get tasks form database when call function', () async {
    //arrange
    when(() => _dbService!.allItems()).thenAnswer((_) async => tasks);
    //act
    await localSource!.getAllTasks();
    //assert
    verify(() => _dbService!.allItems());
    verifyNoMoreInteractions(_dbService);
  });

  test('should list in db is empty when db return null for any reason',
      () async {
    //arrange
    when(() => _dbService!.allItems()).thenAnswer((_) async => null);
    //act
    final result = await localSource!.getAllTasks();
    //assert
    expect(result, equals([]));
  });

  test('should return model when delete task from database successfully',
          () async {
        //arrange
        when(() => _dbService!.deleteItem(any())).thenAnswer((_) async => 2);
        //act
        final result = await localSource!.deleteTask(task);
        //assert
        expect(result, equals(task));
      });

  test('should return model when update task from database successfully',
          () async {
        //arrange
        when(() => _dbService!.updateItem(task)).thenAnswer((_) async => 2);
        //act
        final result = await localSource!.updateTask(task);
        //assert
        expect(result, equals(task));
      });
}
