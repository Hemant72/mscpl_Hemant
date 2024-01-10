import 'package:flutter/material.dart';
import 'package:fydaa_flutter_assignment/features/auth/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.startResendTimer();
  }

  @override
  void dispose() {
    super.dispose();
    authController.resendTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              authController.resendTimer.cancel();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Verify Your Number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Obx(
                () => RichText(
                  text: TextSpan(
                    text: 'Enter the verification code sent to the ',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: '(+91)${authController.maskedNumber.value}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: authController.containerColor.value,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Pinput(
                        length: 6,
                        controller: authController.otpController,
                        focusNode: authController.otpTextFocusNode,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 60,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                        ),
                        onChanged: (pin) {
                          authController.otpSubmit();
                        },
                        onCompleted: (pin) {
                          authController.otpSubmit();
                        },
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 60,
                          textStyle: context.textTheme.bodyLarge,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                        ),
                        errorPinTheme: PinTheme(
                          width: 56,
                          height: 60,
                          textStyle: context.textTheme.bodyLarge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        authController.status.value,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => authController.resendTime.value == 0
                    ? const Center(
                        child: Text("Verification Code is Expired"),
                      )
                    : Center(
                        child: Text(
                          'Verification Code Expires In ${authController.formatTime(authController.resendTime.value)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: authController.resendTime.value == 0
                    ? authController.resendCode
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: authController.changeMobileNumber,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Change Mobile Number ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
