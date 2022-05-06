import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_tdd/core/error/exceptions.dart';
import 'package:todo_app_tdd/core/services/db.dart';
import 'package:todo_app_tdd/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';

class MockDatabase extends Mock implements DbService {}

void main() {
  MockDatabase? databaseService;
  AddTasksLocalDataSource? _localSource;

  setUp(() {
    databaseService = MockDatabase();
    _localSource = AddTasksLocalDataSourceImpl(databaseService!);
  });

  final tTaskModel =
      TaskModel(title: '', description: '', dateTime: '', isDone: 0, views: 0);

  test('should call add task when call method', () async {
    //arrange
    when(() => databaseService!.createItem(tTaskModel))
        .thenAnswer((_) async => 0);
    //act
    await _localSource!.addTask(tTaskModel);
    //assert
    verify(() => databaseService!.createItem(tTaskModel));
    verifyNoMoreInteractions(databaseService);
  });

  test('should return [TaskModel] when stored success in database', () async {
    //arrange
    when(() => databaseService!.createItem(tTaskModel))
        .thenAnswer((_) async => 1);
    //act
    final result = await _localSource!.addTask(tTaskModel);
    //assert
    expect(result, equals(tTaskModel));
  });

  test('should return [CacheException] when throw error', () async {
    //arrange
    when(() => databaseService!.createItem(tTaskModel)).thenThrow(Exception());
    //act
    final result = _localSource!.addTask(tTaskModel);
    //assert
    expect(() => result, throwsA(const TypeMatcher<CacheException>()));
  });
}
