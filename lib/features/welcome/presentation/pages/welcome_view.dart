import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';
import 'package:todo_app_tdd/features/show_task/presentation/pages/show_tasks_view.dart';
import 'package:todo_app_tdd/features/welcome/presentation/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.purple,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            top: -80,
            right: -0,
          ),
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            left: -120,
            top: screenHeight / 2,
          ),
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            right: -70,
            top: screenHeight - 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/graph.png',
                    ),
                    Lottie.asset('assets/images/task.json'),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Welcome to the',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'Taskez'.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 60),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Get Started',
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const ShowTasksView(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
