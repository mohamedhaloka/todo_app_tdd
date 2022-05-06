import 'package:flutter/material.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';

import '../../../../core/themes/theme_manager.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 22) +
              const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(55)),
            color: Colors.white24,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 36),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22)),
            color: ThemeManager.isDark(context)
                ? ColorManager.greyColor
                : Colors.white,
          ),
          child: child,
        ),
      ],
    );
  }
}
