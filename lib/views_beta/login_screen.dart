import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views_beta/home_screen.dart';
import 'package:bpg_erp/views_beta/widgets/custom_button.dart';
import 'package:bpg_erp/views_beta/widgets/custom_textfield.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kSizedBox20,
                Image.asset(
                  "assets/images/bgplogo.png",
                  height: 150,
                  width: 200,
                ),
                const Text(
                  'User Login',
                  style: logInScreenHeaderStyle,
                ),
                kSizedBox50,
                CustomTextField(
                  controller: authController.url,
                  hintText: 'URL (Optional)',
                ),
                kSizedBox20,
                CustomTextField(
                  controller: authController.bpg,
                  hintText: 'BPG',
                ),
                kSizedBox20,
                CustomTextField(
                  controller: authController.password,
                  hintText: 'Password',
                ),
                kSizedBox40,
                CustomButton(
                  height: 45,
                  width: 200,
                  gradient: kGDefaultGradient,
                  navigation: () {
                    Get.offAll(() => const HomeScreen());
                  },
                  widget: const Text(
                    'Log In',
                    style: kSDefaultStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
