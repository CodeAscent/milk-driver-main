import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water/Utils/color_utils.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/whitespaceutils.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key? key,
    required this.onTap,
    required this.tittle,
    this.color,
    this.isBusy = false,
    this.isUpdate = false,
    this.logOut = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final String tittle;
  final Color? color;
  final bool? isBusy;
  final bool? isUpdate;
  final bool? logOut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isUpdate == true || logOut == true ? Get.width * 0.4 : Get.width,
        decoration: BoxDecoration(
            color: color ?? ColorUtils.kcPrimary,
            borderRadius: BorderRadius.circular(8)),
        padding: isBusy!
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 12),
        height: 45,
        alignment: Alignment.bottomCenter,
        child: isBusy!
            ? const SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: ColorUtils.kcWhite,
                  ),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isUpdate == true || logOut == true
                      ? const SizedBox()
                      : const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back,
                            size: 16,
                            color: ColorUtils.kcWhite,
                          ),
                        ),
                  logOut == false
                      ? const SizedBox()
                      : const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.logout,
                            size: 16,
                            color: ColorUtils.kcWhite,
                          ),
                        ),
                  SpaceUtils.ks10.width(),
                  Text(
                    tittle,
                    style: FontStyleUtilities.t2(
                        fontWeight: FWT.bold, fontColor: ColorUtils.kcWhite),
                  ),
                  SpaceUtils.ks10.width(),
                ],
              ),
      ),
    );
  }
}
