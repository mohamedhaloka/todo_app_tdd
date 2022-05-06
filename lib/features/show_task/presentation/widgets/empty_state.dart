import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key, this.imgName, this.text}) : super(key: key);
  final String? text, imgName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/images/' + imgName! + '.json'),
        const SizedBox(
          height: 12,
        ),
        Text(
          text ?? '',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        )
      ],
    );
  }
}
