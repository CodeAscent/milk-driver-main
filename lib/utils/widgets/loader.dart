import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
       borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.black.withOpacity(0.65),
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Lottie.asset(
              'asset/lottie/loading.json',
              height: 80,
              width: 80,
            ),
          ),
        ),
      ),
    );
  }
}
