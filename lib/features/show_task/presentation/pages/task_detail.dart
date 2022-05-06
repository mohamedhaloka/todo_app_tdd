import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/add_task/presentation/widgets/page_header.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_bloc.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_states.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../add_task/presentation/widgets/swipe_line.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskEntity task = ModalRoute.of(context)!.settings.arguments as TaskEntity;
    return WillPopScope(
      onWillPop: () async {
        goBack(context, task);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.pink,
          leading: IconButton(
              onPressed: () => goBack(context, task),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: ColorManager.pink,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ),
                    TaskStatus(task)
                  ],
                ),
              ),
              Text(
                task.description ?? '',
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.grey),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/view.png',color: Colors.grey[400],scale: 5,),
                  const SizedBox(width: 4,),
                  Text(
                    task.views.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goBack(BuildContext context, TaskEntity task) =>
      Navigator.pop(context, task);
}

class TaskStatus extends StatelessWidget {
  const TaskStatus(this.task, {Key? key}) : super(key: key);
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<ShowTaskBloc>();
    return BlocBuilder<ShowTaskBloc, ShowTaskState>(
        builder: (BuildContext context, ShowTaskState state) => InkWell(
              onTap: () {
                homeCubit.setTaskDone(task);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: task.isDone == 0
                        ? ColorManager.blue.withAlpha(50)
                        : ColorManager.lightGreen.withAlpha(50)),
                child: Center(
                  child: Text(
                    task.isDone == 0
                        ? 'in progress'.toUpperCase()
                        : 'done'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: task.isDone == 0
                            ? ColorManager.blue
                            : ColorManager.lightGreen),
                  ),
                ),
              ),
            ));
  }
}
