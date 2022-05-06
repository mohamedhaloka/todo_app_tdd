import 'package:flutter/material.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';

class ToastModel {
  final String? title, description;
  final Color? color;
  final IconData? icon;
  const ToastModel({
    this.color,
    this.title,
    this.description,
    this.icon,
  });

  static ToastModel get addTaskWarning => const ToastModel(
      title: 'Warning',
      description: 'You should fill all inputs',
      icon: Icons.info,
      color: ColorManager.blue);

  static ToastModel get addTaskSuccess => const ToastModel(
      title: 'Success',
      description: 'Add Task Successfully',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static ToastModel get addTaskError => const ToastModel(
      title: 'Error',
      description: 'Try again later..',
      icon: Icons.error,
      color: ColorManager.error);
}
