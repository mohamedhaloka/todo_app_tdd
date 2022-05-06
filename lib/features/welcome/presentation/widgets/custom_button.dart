import 'package:flutter/material.dart';
import 'package:todo_app_tdd/core/themes/colors_manager.dart';
import 'package:todo_app_tdd/core/themes/theme_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.borderRadius,
    this.color,
    this.onTap,
    this.fontColor,
    this.borderColor,
    this.padding,
    this.radius,
  }) : super(key: key);

  final Color? color, borderColor, fontColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Function? onTap;
  final String? text;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        elevation: 0.0,
        highlightElevation: 0.0,
        color: color ??
            (ThemeManager.isDark(context)
                ? ColorManager.greyColor
                : Colors.white),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            side:
                BorderSide(color: borderColor ?? Colors.transparent, width: 2)),
        onPressed: () {
          onTap!.call();
        },
        child: Text(
          text ?? '',
          style: TextStyle(
              color: fontColor ??
                  (ThemeManager.isDark(context)
                      ? Colors.white
                      : ColorManager.purple),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
