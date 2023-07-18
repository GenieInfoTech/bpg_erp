import 'package:bpg_erp/controller/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/common_tapable_panel.dart';
import 'package:bpg_erp/views/widgets/custom_appbar.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:bpg_erp/views/widgets/custom_item_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HangerScanScreen extends StatelessWidget {
  HangerScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        floatingActionButton: homeController.imageList.isEmpty
            ? const SizedBox()
            : CustomButton(
                height: 65,
                width: 250,
                gradient: kGDefaultGradient,
                widget: const Text(
                  'Send to buyer',
                  textAlign: TextAlign.center,
                  style: kSDefaultStyle,
                ),
                navigation: () async {
                  globalController.shareImageAndText('hanger');
                  await globalController.saveDataSP(homeController.imageList);
                },
              ),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: CustomAppBar(
            title: 'Hanger Scan',
            prefixWidget: const Text(
              'Reset',
              style: popUpHeaderStyle,
            ),
            prefixWidgetAction: () async {
              homeController.resetData();
              await globalController.resetSharedPreference();
            },
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Obx(
                () => Column(
                  children: [
                    CommonTapablePanel(),
                    kSizedBox10,
                    if (homeController.isEmptyLoading.value)
                      const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (homeController.imageList.isEmpty)
                      const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "No image uploaded yet",
                            style: textStyle,
                          ),
                        ),
                      ),
                    for (int i = homeController.imageList.length - 1;
                        i >= 0;
                        i--)
                      CustomItemContent(
                        itemType: "Hanger ",
                        index: i,
                      ),
                    kSizedBox80
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}