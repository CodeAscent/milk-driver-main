import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget selectLanguageButton(
    {String? prefixPath,
    required onPress,
    required String? title,
    double? width,
    required TextStyle? textStyle,
    required Color? color}) {
  return Container(
    height: 56,
    width: width,
    child: ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => color ?? Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: [
        
          Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          const SizedBox(
            width: 10,
          ),
            SvgPicture.asset(
            prefixPath ?? '',
            colorFilter: ColorFilter.mode(Colors.white as Color, BlendMode.srcIn)
          ),
          
        ],
      ),
    ),
  );
}
