import 'package:bpg_erp/utils/const/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/home_screen.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:bpg_erp/views/widgets/custom_textfield.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kCBackgroundColor,
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
                  logo,
                  height: 150,
                  width: 200,
                ),
                const Text(
                  'User Login',
                  style: kTSLogInScreenHeader,
                ),
                kSizedBox50,
                Container(
                  height: 45,
                  decoration: kTextFieldDecoration,
                  child: CustomTextField(
                    controller: authController.url,
                    hintText: 'URL (Optional)',
                  ),
                ),
                kSizedBox20,
                Container(
                  height: 45,
                  decoration: kTextFieldDecoration,
                  child: CustomTextField(
                    controller: authController.userName,
                    hintText: 'User name',
                  ),
                ),
                kSizedBox20,
                Container(
                  height: 45,
                  decoration: kTextFieldDecoration,
                  child: CustomTextField(
                    controller: authController.password,
                    hintText: 'Password',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
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
                    style: kTSDefaultStyle,
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
