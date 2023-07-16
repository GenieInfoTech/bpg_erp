import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/views_beta/home_screen.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:bpg_erp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/bgplogo.png",
              height: 200,
              width: 200,
            ),
            const Text(
              'User Login',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: authController.url,
              hintText: 'URL (Optional)',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: authController.bpg,
              hintText: 'BPG',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: authController.password,
              hintText: 'Password',
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              height: 45,
              width: 200,
              navigation: () {
                Get.to(const HomeScreen());
              },
              widget: const Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
