import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tdd/core/themes/theme_manager.dart';
import 'package:todo_app_tdd/dependency_container.dart';
import 'package:todo_app_tdd/features/show_task/presentation/bloc/show_tasks_bloc.dart';
import 'package:todo_app_tdd/features/welcome/presentation/pages/welcome_view.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShowTaskBloc(sl(), sl(), sl())..getAllTasks())
      ],
      child: DynamicTheme(
        builder: (BuildContext conetxt , ThemeData theme)=>MaterialApp(
          title: 'Taskez',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const WelcomeView(),
        ),
          themeCollection: ThemeCollection(themes: {
            1: ThemeManager.theme,
            0: ThemeManager.darkTheme,
          })
      ),
    );
  }
}
