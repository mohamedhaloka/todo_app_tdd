import 'package:flutter/material.dart';

import '../../../../core/themes/colors_manager.dart';


class SwipeLine extends StatelessWidget {
  const SwipeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 3,
        margin: const EdgeInsets.only(top: 2),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(22)),
          color: ColorManager.lightGrey,
        ),
      ),
    );
  }
}
