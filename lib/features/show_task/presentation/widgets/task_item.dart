import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_tdd/core/themes/theme_manager.dart';
import 'package:todo_app_tdd/core/time/time_format.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_bloc.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_states.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {Key? key}) : super(key: key);
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowTaskBloc>();
    return Slidable(
      key: ValueKey(task.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible:
            DismissiblePane(onDismissed: () => homeBloc.deleteTask(task)),
        children: [
          SlidableAction(
            onPressed: (BuildContext? context) => homeBloc.deleteTask(task),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => homeBloc.goToTaskDetail(context, task),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: ThemeManager.isDark(context) ? Colors.black : Colors.white,
              boxShadow: ThemeManager.isDark(context)
                  ? []
                  : [
                      BoxShadow(
                          color: Colors.grey[100]!,
                          offset: const Offset(0, 6),
                          blurRadius: 8,
                          spreadRadius: 1),
                    ]),
          child: Row(
            children: [
              BlocBuilder<ShowTaskBloc, ShowTaskState>(
                  builder: (BuildContext context, ShowTaskState state) => InkWell(
                        onTap: () => homeBloc.setTaskDone(task),
                        child: Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: task.isDone == 1
                                  ? Colors.green.shade300
                                  : Colors.grey[100]!),
                          child: CircleAvatar(
                            backgroundColor: task.isDone == 1
                                ? Colors.green
                                : Colors.grey[200],
                            child: task.isDone == 1
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      )),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      TimeFormat.instance.formatDate(
                          dayNameWithTime, DateTime.parse(task.dateTime!)),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
