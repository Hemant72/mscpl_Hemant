import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fydaa_flutter_assignment/features/auth/screen/otp_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  RxBool allowNotification = false.obs;
  RxString maskedNumber = "".obs;
  RxInt resendTime = 160.obs;
  late Timer resendTimer;
  RxBool isResending = false.obs;
  final otpTextFocusNode = FocusNode();
  Rx<Color> containerColor = Rx<Color>(Colors.white);
  RxString status = "".obs;
  RxBool isButtonEnabled = false.obs;

  void startResendTimer() {
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime.value > 0) {
        resendTime.value--;
      } else {
        isResending.value = false;
        resendTimer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    String formattedSeconds =
        remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';
    return '$formattedMinutes:$formattedSeconds';
  }

  void resendCode() {
    isResending.value = true;
    resendTime.value = 160;
    startResendTimer();
  }

  void changeMobileNumber() {
    resendTimer.cancel();
    Get.back();
  }

  void submit() {
    maskedNumber.value = maskPhoneNumber(phoneController.text);
    Get.to(() => const OtpScreen());
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 6) {
      return '${phoneNumber.substring(0, 2)}******${phoneNumber.substring(phoneNumber.length - 2)}';
    } else {
      return phoneNumber;
    }
  }

  void otpSubmit() {
    if (otpController.text == "123456" && otpController.text.length == 6) {
      containerColor.value = Colors.green;
      status.value = "Verified";
    } else if (otpController.text != "123456" &&
        otpController.text.length == 6) {
      containerColor.value = Colors.redAccent;
      status.value = "Invalid OTP";
    } else {
      containerColor.value = Colors.white;
      status.value = "";
    }
  }
}
