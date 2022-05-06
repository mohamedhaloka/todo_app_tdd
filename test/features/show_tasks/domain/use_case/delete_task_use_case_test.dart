import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/delete_task_use_case.dart';

class MockHomeRepository extends Mock implements ShowTaskRepository {}

void main() {
  MockHomeRepository? repository;
  DeleteTaskUseCase? deleteTask;

  setUp(() {
    repository = MockHomeRepository();
    deleteTask = DeleteTaskUseCase(repository!);
  });

  final task =
      TaskEntity(title: '', description: '', dateTime: '', isDone: 0, views: 0,id: 0);

  test('should call repository one time when call delete use case', () async {
    //arrange
    when(() => repository!.deleteTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    await deleteTask!(TaskParams(taskEntity: task));
    //assert
    verify(() => repository!.deleteTask(task));
    verifyNoMoreInteractions(repository);
  });

  test('should return deleted task when return right side of repository',
      () async {
    //arrange
    when(() => repository!.deleteTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    final result = await deleteTask!(TaskParams(taskEntity: task));
    //assert
    expect(result, equals(Right(task)));
  });

  test('should return failure when repository return [ERROR] failure',
      () async {
    //arrange
    when(() => repository!.deleteTask(task))
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result = await deleteTask!(TaskParams(taskEntity: task));
    //assert
    expect(result, equals(const Left(Failure())));
  });
}
