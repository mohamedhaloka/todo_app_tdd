import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/all_tasks_use_case.dart';

class MockHomeRepository extends Mock implements ShowTaskRepository {}

void main() {
  MockHomeRepository? repository;
  AllTasksUseCase? getAllTasks;

  setUp(() {
    repository = MockHomeRepository();
    getAllTasks = AllTasksUseCase(repository!);
  });

  final tasks = [
    TaskEntity(title: '', description: '', dateTime: '', isDone: 0, views: 0),
    TaskEntity(title: '', description: '', dateTime: '', isDone: 0, views: 0),
    TaskEntity(title: '', description: '', dateTime: '', isDone: 0, views: 0),
  ];

  test('should call repository one time when call use case', () async {
    //arrange
    when(() => repository!.getAllTasks()).thenAnswer((_) async => Right(tasks));
    //act
    await getAllTasks!(NoParams());
    //assert
    verify(() => repository!.getAllTasks());
    verifyNoMoreInteractions(repository);
  });

  test('should return list of tasks when return right side of repository',
      () async {
    //arrange
    when(() => repository!.getAllTasks()).thenAnswer((_) async => Right(tasks));
    //act
    final result = await getAllTasks!(NoParams());
    //assert
    expect(result, equals(Right(tasks)));
  });

  test('should return failure when repository return [ERROR] failure',
      () async {
    //arrange
    when(() => repository!.getAllTasks())
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result = await getAllTasks!(NoParams());
    //assert
    expect(result, equals(const Left(Failure())));
  });
}
