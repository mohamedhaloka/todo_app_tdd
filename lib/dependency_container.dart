import 'package:get_it/get_it.dart';
import 'package:todo_app_tdd/core/services/db.dart';
import 'package:todo_app_tdd/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/add_task/data/repository/add_task_repository_impl.dart';
import 'package:todo_app_tdd/features/add_task/domain/repositiory/add_task_repository.dart';
import 'package:todo_app_tdd/features/add_task/domain/use_case/add_task_use_case.dart';
import 'package:todo_app_tdd/features/show_task/data/data_source/show_tasks_local_data_source.dart';
import 'package:todo_app_tdd/features/show_task/data/repository/show_tasks_repository_impl.dart';
import 'package:todo_app_tdd/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/all_tasks_use_case.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/delete_task_use_case.dart';

import 'features/show_task/domain/use_case/update_task_use_case.dart';

final sl = GetIt.I;

Future<void> init() async {
  //Use case
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));

  sl.registerLazySingleton(() => AllTasksUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUSeCase(sl()));

  //Repository
  sl.registerLazySingleton<AddTaskRepository>(
      () => AddTaskRepositoryImpl(localSource: sl()));

  sl.registerLazySingleton<ShowTaskRepository>(() => ShowTaskRepositoryImpl(sl()));

  //Data Source
  sl.registerLazySingleton<AddTasksLocalDataSource>(
      () => AddTasksLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<ShowTaskLocalDataSource>(
      () => ShowTaskLocalDataSourceImpl(sl()));

  //Data base
  sl.registerLazySingleton(() => DbService());
}
