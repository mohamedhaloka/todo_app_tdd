import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_bloc.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_states.dart';
import 'package:todo_app_tdd/features/show_task/presentation/widgets/mode_switcher.dart';
import '../../../../core/themes/theme_manager.dart';

class ShowTasksView extends StatelessWidget {
  const ShowTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowTaskBloc homeBloc = context.read<ShowTaskBloc>();
    return Scaffold(
      appBar: AppBar(
        actions:const [
          ModeSwitcher()
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => homeBloc.goToAddTask(context),
        enableFeedback: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        tooltip: 'Add new task',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 0.0,
        backgroundColor: ColorManager.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ShowTaskBloc, ShowTaskState>(
              builder: (BuildContext context, ShowTaskState state) {
                if (state is HomeLoaded) {
                  return homeBloc.tabs[homeBloc.currentPage].view!;
                } else if (state is HomeError) {
                  return Center(child: Text(state.msg ?? ''));
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const BottomTabs()
        ],
      ),
    );
  }
}

class BottomTabs extends StatelessWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowTaskBloc homeBloc = context.read<ShowTaskBloc>();
    return BlocBuilder<ShowTaskBloc, ShowTaskState>(
        builder: (BuildContext context, ShowTaskState state) => Container(
              height: 60,
              color: ThemeManager.isDark(context) ? Colors.black : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: homeBloc.tabs
                    .map((e) => Expanded(
                            child: InkWell(
                          onTap: () => homeBloc.changeActiveTab(e.id!),
                          child: Image.asset(
                            'assets/images/' + e.imgName! + '.png',
                            scale: 20,
                            color: e.id == homeBloc.currentPage
                                ? ThemeManager.isDark(context)
                                    ? Colors.white
                                    : Colors.black
                                : ThemeManager.isDark(context)
                                    ? Colors.grey[600]
                                    : Colors.grey[300],
                          ),
                        )))
                    .toList(),
              ),
            ));
  }
}
