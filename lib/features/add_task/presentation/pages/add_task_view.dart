import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';
import 'package:todo_app_tdd/features/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:todo_app_tdd/features/add_task/presentation/bloc/add_task_state.dart';
import 'package:todo_app_tdd/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:todo_app_tdd/features/add_task/presentation/widgets/page_header.dart';

import '../../../../dependency_container.dart';
import '../../../welcome/presentation/widgets/custom_button.dart';
import '../model/toast_model.dart';
import '../widgets/swipe_line.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskBloc(sl()),
      child: const AddTaskView(),
    );
  }
}

class AddTaskView extends StatelessWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addTaskBloc = context.read<AddTaskBloc>();
    return WillPopScope(
      onWillPop: () async {
        addTaskBloc.goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.blue,
          leading: IconButton(
              onPressed: () => addTaskBloc.goBack(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: ColorManager.blue,
        body: PageHeader(
          child: ListView(
            padding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              CustomTextField(
                title: 'Title',
                controller: addTaskBloc.titleController,
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
              CustomTextField(
                title: 'Description',
                maxLines: 12,
                controller: addTaskBloc.descriptionController,
              ),
              const SizedBox(
                height: 40,
              ),
              const AddBtn()
            ],
          ),
        ),
      ),
    );
  }
}

class AddBtn extends StatelessWidget {
  const AddBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTaskBloc bloc = context.read<AddTaskBloc>();
    return BlocConsumer<AddTaskBloc, AddTaskState>(
        listener: (BuildContext context, AddTaskState state) {
      if (state is AddTaskLoad) {
        bloc.clearControllers();
        bloc.showToast(context, ToastModel.addTaskSuccess);
      } else if (state is AddTaskError) {
        bloc.showToast(context, ToastModel.addTaskError);
      }
    }, builder: (BuildContext context, AddTaskState state) {
      if (state is AddTaskLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddTaskError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: Colors.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveTask(context),
      );
    });
  }
}
