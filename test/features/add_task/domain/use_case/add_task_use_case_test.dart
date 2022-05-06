import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/add_task/domain/repositiory/add_task_repository.dart';
import 'package:todo_app_tdd/features/add_task/domain/use_case/add_task_use_case.dart';

class MockAddTaskRepository extends Mock implements AddTaskRepository {}

void main() {
  MockAddTaskRepository? repository;
  AddTaskUseCase? useCase;

  setUp(() {
    repository = MockAddTaskRepository();
    useCase = AddTaskUseCase(repository!);
  });

  final tTask =
      TaskEntity(title: '', description: '', isDone: 0, dateTime: '', views: 0);

  final tTaskModel =
      TaskModel(title: '', description: '', isDone: 0, dateTime: '', views: 0);

  test('should return [Task Entity] when data return success', () async {
    //arrange
    when(() => repository!.addTask(tTaskModel))
        .thenAnswer((_) async =>  Right(tTask));
    //act
    final result = await useCase!(AddTaskParam(tTaskModel));
    //assert
    verify(() => repository!.addTask(tTaskModel));
    verifyNoMoreInteractions(repository);
    expect(result, equals( Right(tTask)));
  });

  test('should return [Failure] when data return error', () async {
    //arrange
    when(() => repository!.addTask(tTaskModel))
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result = await useCase!(AddTaskParam(tTaskModel));
    //assert
    verify(() => repository!.addTask(tTaskModel));
    verifyNoMoreInteractions(repository);
    expect(result, equals(const Left(Failure())));
  });
}
