import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';
import 'package:todo_app_tdd/core/use_case/use_case.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/domain/use_case/add_task_use_case.dart';
import 'package:todo_app_tdd/features/add_task/presentation/bloc/add_task_state.dart';
import '../model/toast_model.dart';

class AddTaskBloc extends Cubit<AddTaskState> {
  final AddTaskUseCase addTaskUseCase;
  AddTaskBloc(this.addTaskUseCase) : super(AddTaskEmpty());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskModel get _task => TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      isDone: 0,
      views: 0,
      dateTime: DateTime.now().toString());

  bool get validateInputs =>
      titleController.text.isEmpty || descriptionController.text.isEmpty;

  void saveTask(BuildContext context) async {
    if (validateInputs) {
      showToast(context, ToastModel.addTaskWarning);
      return;
    }

    emit(AddTaskLoading());
    (await addTaskUseCase.call(AddTaskParam(_task))).fold(
        (error) => emit(AddTaskError(error.msg)),
        (task) => emit(AddTaskLoad(task: task)));
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }

  void showToast(BuildContext context, ToastModel toastModel) {
    MotionToast(
      icon: toastModel.icon!,
      title: Text(toastModel.title ?? '', style: testStyle),
      description: Text(
        toastModel.description ?? '',
        style: testStyle,
      ),
      position: MOTION_TOAST_POSITION.bottom,
      animationType: ANIMATION.fromBottom,
      primaryColor: toastModel.color!,
    ).show(context);
  }

  TextStyle get testStyle => const TextStyle(color: ColorManager.greyColor);

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
