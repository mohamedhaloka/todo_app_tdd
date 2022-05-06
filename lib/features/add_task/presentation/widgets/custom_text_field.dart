import 'package:flutter/material.dart';
import '../../../../core/themes/colors_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.maxLines,
      this.textInputAction,
      this.title,
      this.keyboardType,
      this.maxLength})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText, title;
  final TextInputType? keyboardType;
  final int? maxLength,maxLines;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: ColorManager.blue,
                  fontWeight: FontWeight.w700
                    ),
              ),
              const Expanded(
                child: Divider(
                  indent: 12,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: controller,
            cursorColor: ColorManager.blue,
            keyboardType: keyboardType,
            maxLength: maxLength,
            maxLines: maxLines,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: ColorManager.lightGrey2,
                    fontWeight: FontWeight.w400),
                counterText: ''),
          ),
        ],
      ),
    );
  }

  InputBorder get inputBorder => const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorManager.lightGrey));
}
