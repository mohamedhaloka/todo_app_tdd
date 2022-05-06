import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/data/repository/add_task_repository_impl.dart';
import 'package:todo_app_tdd/features/add_task/domain/repositiory/add_task_repository.dart';

class MockAddTaskLocalDataSource extends Mock
    implements AddTasksLocalDataSource {}

void main() {
  MockAddTaskLocalDataSource? _localSource;
  AddTaskRepository? _repository;

  setUp(() {
    _localSource = MockAddTaskLocalDataSource();
    _repository = AddTaskRepositoryImpl(localSource: _localSource);
  });

  final tTaskModel =
      TaskModel(title: '', dateTime: '', description: '', isDone: 0, views: 0);

  test('should return [TaskModel] when everything work fine', () async {
    //arrange
    when(() => _localSource!.addTask(tTaskModel))
        .thenAnswer((_) async => tTaskModel);
    //act
    final result = await _repository!.addTask(tTaskModel);
    //assert
    expect(result, equals(Right(tTaskModel)));
  });
}
