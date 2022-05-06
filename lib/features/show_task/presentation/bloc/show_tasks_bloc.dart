import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/all_tasks_use_case.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/delete_task_use_case.dart';
import 'package:todo_app_tdd/features/show_task/domain/use_case/update_task_use_case.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_states.dart';
import 'package:todo_app_tdd/features/show_task/presentation/model/tab_model.dart';
import 'package:todo_app_tdd/features/show_task/presentation/pages/done_tasks_view.dart';
import 'package:todo_app_tdd/features/show_task/presentation/pages/task_detail.dart';
import '../../../add_task/presentation/pages/add_task_view.dart';
import '../pages/all_tasks_view.dart';

class ShowTaskBloc extends Cubit<ShowTaskState> {
  final AllTasksUseCase _allTasksUseCase;
  final DeleteTaskUseCase _deleteTask;
  final UpdateTaskUSeCase _updateTask;
  ShowTaskBloc(this._allTasksUseCase, this._deleteTask, this._updateTask)
      : super(HomeEmpty());

  int currentPage = 0;

  List<TabModel> tabs = [
    const TabModel(id: 0, imgName: 'home', view: AllTasks()),
    const TabModel(id: 1, imgName: 'check-mark', view: DoneTasks()),
  ];

  List<TaskEntity> tasks = [];
  List<TaskEntity>? mostVisitedTasks = [];
  List<TaskEntity>? doneTasks = [];

  void changeActiveTab(int tabId) {
    currentPage = tabId;
    emit(HomeLoaded());
  }

  void setTaskDone(TaskEntity task) {
    if (task.isDone == 0) {
      task.isDone = 1;
    } else {
      task.isDone = 0;
    }
    updateLists();
    updateTask(task);
  }

  void goToAddTask(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (_) => const AddTask());
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getAllTasks();
  }

  void goToTaskDetail(BuildContext context, TaskEntity task) async {
    task.views = (task.views ?? 0) + 1;
    //Navigate
    final result = await navigateToTaskDetail(context, task) as TaskEntity;
    //Update
    update(result);
  }

  Future navigateToTaskDetail(BuildContext context, TaskEntity task) async {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => const TaskDetailView(),
        settings: RouteSettings(arguments: task));
    return await Navigator.of(context).push(materialPageRoute);
  }

  void update(TaskEntity result) {
    updateLists();
    updateTask(result);
  }

  void updateLists() {
    mostVisitedTasks = null;
    doneTasks = null;
    //Most Visited List
    mostVisitedTasks = tasks.where((element) => element.views! > 0).toList();
    mostVisitedTasks!.sort((b, a) => a.views!.compareTo(b.views!));
    //Done Tasks
    doneTasks = tasks.where((task) => task.isDone != 0).toList();
  }

  //Working with Database
  Future<void> getAllTasks() async => (await _allTasksUseCase(NoParams()))
          .fold((e) => emit(HomeError(e.msg)), (tasks) {
        this.tasks = tasks;
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> deleteTask(TaskEntity task) async =>
      (await _deleteTask(TaskParams(taskEntity: task)))
          .fold((e) => log(e.msg ?? ''), (task) {
        tasks.removeWhere((element) => element.id == task.id);
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> updateTask(TaskEntity task) async =>
      (await _updateTask(TaskParams(taskEntity: task))).fold(
        (e) => log(e.msg ?? ''),
        (task) => emit(HomeLoaded()),
      );
}
