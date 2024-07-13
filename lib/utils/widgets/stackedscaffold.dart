import 'package:flutter/material.dart';
import 'package:water/Utils/color_utils.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/utils/uttil_helper.dart';
import 'package:water/utils/whitespaceutils.dart';

class StackedScaffold extends StatefulWidget {
  const StackedScaffold({
    super.key,
    required this.tittle,
    required this.body,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    required this.stackedEntries,
    this.headerPadding,
    this.actionIcon,
    this.leadingIcon,
    this.extraWidget,
  });

  final String tittle;
  final Widget body;
  final List<Widget> stackedEntries;
  final EdgeInsetsGeometry? headerPadding;
  final bool? extendBody, extendBodyBehindAppBar;
  final Widget? actionIcon;
  final Widget? leadingIcon;
  final Widget? extraWidget;

  @override
  State<StackedScaffold> createState() => _StackedScaffoldState();
}

class _StackedScaffoldState extends State<StackedScaffold> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: widget.extendBody!,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar!,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 0),
            height: size.height,
            width: size.width,
            child: widget.body,
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(left: 27 + 0, right: 24 + 0, top: 20),
          //     child: ClipOval(
          //       child: BackdropFilter(
          //         filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //         child: Opacity(
          //           opacity: .010,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               /// gradient: RadialGradient(
          //               ///     colors: List.generate(
          //               ///   15,
          //               ///   (index) => Colors.black.withOpacity(index / 50),
          //               /// ).toList()),
          //               color: Colors.black.withOpacity(1),
          //             ),
          //             margin: const EdgeInsets.only(
          //                 top: 0, left: 0 + 0, right: 0 + 0),
          //             height: 100,
          //             width: double.infinity,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            // height: 74,
            width: size.width,
            top: kToolbarHeight,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: widget.headerPadding ??
                        const EdgeInsets.only(
                            left: 10, right: 12, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(left: 24, right: 24),
                    // height: 54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: ColorUtils.kcTransparent.withOpacity(.1),
                            offset: const Offset(0, 5),
                            spreadRadius: 0,
                            blurRadius: 30),
                      ],
                    ),
                    child: Row(
                      children: [
                        widget.leadingIcon ?? const SizedBox(width: 8),
                        const SizedBox(width: 4),
                        Text(widget.tittle,
                            style: FontStyleUtilities.h3(
                                fontWeight: FWT.semiBold)),
                        const Spacer(),
                        widget.actionIcon ?? const SizedBox()
                      ],
                    )),
                if (widget.extraWidget != null) widget.extraWidget!,
                SpaceUtils.ks30.height(),
              ],
            ),
          ),
          ...widget.stackedEntries
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(0, 0, double.infinity, 97);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
