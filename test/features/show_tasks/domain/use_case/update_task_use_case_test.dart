import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/update_task_use_case.dart';

class MockHomeRepository extends Mock implements ShowTaskRepository {}

void main() {
  MockHomeRepository? repository;
  UpdateTaskUSeCase? updateTask;

  setUp(() {
    repository = MockHomeRepository();
    updateTask = UpdateTaskUSeCase(repository!);
  });

  final task = TaskEntity(
      title: '', description: '', dateTime: '', isDone: 0, views: 0, id: 0);

  test('should call repository one time when call update use case', () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    await updateTask!(TaskParams(taskEntity: task));
    //assert
    verify(() => repository!.updateTask(task));
    verifyNoMoreInteractions(repository);
  });

  test('should return updated task when return right side of repository',
      () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    final result = await updateTask!(TaskParams(taskEntity: task));
    //assert
    expect(result, equals(Right(task)));
  });

  test('should return failure when repository return [ERROR] failure',
      () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result = await updateTask!(TaskParams(taskEntity: task));
    //assert
    expect(result, equals(const Left(Failure())));
  });
}
