import 'package:flutter/material.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_bloc.dart';
import 'package:todo_app_tdd/features/show_task/presentation/widgets/most_visited_task_item.dart';
import 'package:todo_app_tdd/features/show_task/presentation/widgets/task_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/show_tasks_states.dart';
import '../widgets/empty_state.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowTaskBloc>();
    return BlocBuilder<ShowTaskBloc, ShowTaskState>(
        builder: (BuildContext context, ShowTaskState state) {
          return homeBloc.tasks.isEmpty
              ? const EmptyState(
            imgName: 'no-tasks',
            text: 'No Tasks Yet',
          )
              : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            children: [
              if (homeBloc.mostVisitedTasks!.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Most Visited Tasks',
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        MostVisitedTaskItem(homeBloc.mostVisitedTasks![index]),
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      indent: 12,
                      endIndent: 12,
                    ),
                    itemCount: homeBloc.mostVisitedTasks!.length,
                  ),
                ),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'All Tasks',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (BuildContext context, int index) =>
                    TaskItem(homeBloc.tasks[index]),
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  indent: 12,
                  endIndent: 12,
                ),
                itemCount: homeBloc.tasks.length,
              )
            ],
          );
        });
  }
}


