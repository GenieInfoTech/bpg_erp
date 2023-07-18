import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/views/card_scan_screen.dart';
import 'package:bpg_erp/views/hanger_scan_screen.dart';
import 'package:bpg_erp/views/login_screen.dart';
import 'package:bpg_erp/views/widgets/custom_appbar.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: CustomAppBar(
          title: 'DashBoard Activity',
          prefixWidget: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
          ),
          prefixWidgetAction: () {
            Get.offAll(() => LogInScreen());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/sky2.png",
            fit: BoxFit.cover,
          ),
          Image.asset("assets/images/leaves.png"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: CustomButton(
                  height: 180,
                  gradient: kGDefaultGradient,
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.document_scanner_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Visiting Card Scan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  navigation: () {
                    Get.find<HomeController>().resetData();
                    Get.to(() => CardScanScreen());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: CustomButton(
                  gradient: kGDefaultGradient,
                  height: 180,
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.dry_cleaning_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hangar Scan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  navigation: () {
                    Get.find<HomeController>().resetData();
                    Get.to(() => HangerScanScreen());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}