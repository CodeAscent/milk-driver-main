import 'package:flutter/material.dart';
import 'package:get/get.dart';

appSnackBar({
  required String title,
  required String message,
  required bool success,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    colorText: Colors.white,
    borderRadius: 10,
    backgroundColor: success ? const Color(0xFF60c569) : Colors.redAccent,
    icon: Image.asset(
      success
          ? "asset/images/success_toast.png"
          : "asset/images/failure_toast.png",
      height: 25,
      width: 25,
      color: Colors.white,
    ),
  );
}
