import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/Utils/color_utils.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.length,
    this.suffix,
    this.isObs = false,
  });
  
  final TextEditingController controller;
  final String hint, icon;
  final bool? isObs;
  final Widget? suffix;
  final int? length;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObs!,
      controller: widget.controller,
      maxLength: widget.length,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        counterText: '',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5, top: 15, bottom: 15),
          child: SvgPicture.asset(
            widget.icon,
            color: ColorUtils.kcLightTextColor,
          ),
        ),
        hintStyle: FontStyleUtilities.h6(
          fontColor: ColorUtils.kcLightTextColor,
        ),
        hintText: widget.hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: isDark.value ? ColorUtils.kcTextFieldColor.withOpacity(0.1) : ColorUtils.kcTextFieldColor,
      ),
    );
  }
}
