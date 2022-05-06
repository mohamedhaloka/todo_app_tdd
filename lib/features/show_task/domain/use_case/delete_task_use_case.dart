import 'package:dartz/dartz.dart';
import 'package:todo_app_tdd/core/error/failure.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';

class DeleteTaskUseCase implements UseCase<TaskEntity, TaskParams> {
  final ShowTaskRepository _repository;
  const DeleteTaskUseCase(this._repository);

  @override
  Future<Either<Failure, TaskEntity>> call(TaskParams params) {
    return _repository.deleteTask(params.taskEntity!);
  }
}
