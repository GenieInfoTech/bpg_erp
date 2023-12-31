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

class CardScanScreen extends StatelessWidget {
  CardScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: kCBackgroundColor,
        resizeToAvoidBottomInset: false,
        floatingActionButton: homeController.imageList.isEmpty
            ? const SizedBox()
            : CustomButton(
                height: 65,
                width: 260,
                gradient: kGDefaultGradient,
                widget: const Text(
                  'Send to merchandiser',
                  textAlign: TextAlign.center,
                  style: kTSDefaultStyle,
                ),
                navigation: () async {
                  globalController.shareImageAndText('card');
                  await globalController.saveDataSP(homeController.imageList);
                },
              ),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: Obx(
            () => CustomAppBar(
              title: 'Visiting Card Scan',
              prefixWidget: homeController.imageList.isEmpty
                  ? null
                  : const Text(
                      'Reset',
                      style: kTSPopUpHeader,
                    ),
              prefixWidgetAction: () async {
                homeController.showResetConfirmDialog(context);
                await globalController.resetSharedPreference();
              },
            ),
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
                            style: kTSDefault1,
                          ),
                        ),
                      ),
                    for (int i = homeController.imageList.length - 1; i >= 0; i--)
                      CustomItemContent(
                        itemType: "Card ",
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
