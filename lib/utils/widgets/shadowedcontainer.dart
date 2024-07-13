import 'package:flutter/material.dart';
import 'package:water/Utils/color_utils.dart';

class CommonShadowContainer extends StatelessWidget {
  const CommonShadowContainer({
    Key? key,
    this.alignment,
    this.padding,
    this.color,
    this.foregroundDecoration,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.width,
    this.height,
    this.borderRadius = 8,
  }) : super(key: key);
  final Widget? child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  final Decoration? foregroundDecoration;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final double? width, borderRadius, height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        transformAlignment: transformAlignment,
        margin: margin,
        foregroundDecoration: foregroundDecoration,
        decoration: BoxDecoration(
          color: color ??  Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: ColorUtils.kcTransparent.withOpacity(.1))
          ],
        ),
        padding: padding,
        alignment: alignment,
        child: child);
  }
}
