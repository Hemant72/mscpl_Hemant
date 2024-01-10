import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fydaa_flutter_assignment/features/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Enter Your Mobile Number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "We need to Verify your Mobile Number",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 32),
              RichText(
                text: const TextSpan(
                  text: 'Mobile Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authController.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Enter Mobile no',
                  hintStyle: const TextStyle(color: Colors.black38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Set the border color to grey
                    ), // Set border radius to 12
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Set the border color to grey
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Set the border color to grey
                    ),
                  ),
                ),
                maxLength: 10,
                onChanged: (value) {
                  if (value.length == 10) {
                    authController.isButtonEnabled.value = true;
                  } else {
                    authController.isButtonEnabled.value = false;
                  }
                },
              ),
              const Spacer(),
              Obx(
                () => authController.isButtonEnabled.value == false
                    ? GestureDetector(
                        onTap: null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Text(
                                'Get Otp',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: authController.submit,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Text(
                                'Get Otp',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              const Spacer(),
              const Spacer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: authController.allowNotification.value,
                          onChanged: (value) {
                            authController.allowNotification.value = value!;
                          },
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Allow Faydaa to send financial knowledge and critical alerts on whatsapp',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
