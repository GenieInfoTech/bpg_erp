import 'dart:developer';

import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/utils/const/value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxBool textScanning = RxBool(false);
  XFile? imageFile;
  final RxList<RxString> scannedTextList = RxList([''.obs]);
  //final RxBool isImageUploaded = RxBool(false);
  final RxBool isEmptyLoading = RxBool(false);
  final RxList<TextEditingController> textEditorList =
      RxList([TextEditingController()]);
  final RxList<RxBool> isEditingModeList = RxList([false.obs]);
  final RxList imageList = RxList([]);

  // final FocusNode textFocusNode = FocusNode();
  final RxList<FocusNode> textFocusNodeList = RxList([FocusNode()]);

  final RxList<RxBool> isImageUploadedList = RxList([false.obs]);
  final RxList<RxBool> isLoadingList = RxList([false.obs]);

  resetData() {
    textScanning.value = false;
    imageFile = null;
    imageList.clear();
    isEmptyLoading.value = false;
    scannedTextList.clear();
    textEditorList.clear();
    isEditingModeList.clear();
    textFocusNodeList.clear();
    isImageUploadedList.clear();
    isLoadingList.clear();
    scannedTextList.add(''.obs);
    textEditorList.add(TextEditingController());
    isEditingModeList.add(false.obs);
    textFocusNodeList.add(FocusNode());
    isImageUploadedList.add(false.obs);
    isLoadingList.add(false.obs);
  }

  Future<XFile?> cropImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        cropGridRowCount: 2,
        cropGridColumnCount: 2,
        cropGridColor: Colors.grey,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ),
    );
    if (croppedImage != null) {
      return XFile(croppedImage.path);
    } else {
      return null;
    }
  }

  Future<void> getImage(source, index) async {
    try {
      // resetData();
      // log('index' + index.toString());
      final pickedImage = await ImagePicker().pickImage(source: source);
      isLoadingList[index].value = true;
      isEmptyLoading.value = true;
      if (pickedImage != null) {
        textScanning.value = true;
        var croppedImage = await cropImage(pickedImage.path);
        if (croppedImage != null) {
          isImageUploadedList[index].value = true;
          imageFile = croppedImage;
          await getRecognisedText(croppedImage, index);
        } else {
          isEmptyLoading.value = false;
          isLoadingList[index].value = false;
          textScanning.value = false;
          imageFile = null;
          isImageUploadedList[index].value = false;
        }
      } else {
        isEmptyLoading.value = false;
        isLoadingList[index].value = false;
        textScanning.value = false;
        imageFile = null;
      }
    } catch (e) {
      isEmptyLoading.value = false;
      isLoadingList[index].value = false;
      textScanning.value = false;
      imageFile = null;
      scannedTextList[index].value = "Error occurred when scanning";
    }
  }

  getRecognisedText(XFile image, index) async {
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    // List<String> textRows = [];
    String scanText = "";
    //  print(recognisedText.text);
    //scannedText.value = '';
    for (TextBlock block in recognisedText.blocks) {
      // print(block.lines.length);
      for (TextLine line in block.lines) {
        scanText += line.text + '\n';
        scannedTextList[index].value = scanText.trim();
      }
    }
    scannedTextList[index].value = scanText.trim();

    scannedTextList[index].value = scanText;
    isEmptyLoading.value = false;
    imageList.add({'image': image.path, 'text': scannedTextList[index].value});
    isLoadingList.add(false.obs);
    isImageUploadedList.add(false.obs);
    textEditorList.add(textEditorList[index]);
    isEditingModeList.add(false.obs);
    scannedTextList.add(''.obs);
    log('list' + scannedTextList.toString());
    textScanning.value = false;
    isLoadingList[index].value = false;
    textFocusNodeList.add(FocusNode());
  }

  deleteData(index) {
    imageList.removeAt(index);
  }
  // updateData(index){

  // }

  toggleEditingMode(index) {
    if (isEditingModeList[index].value == true) {
      scannedTextList[index].value = textEditorList[index].text;
      imageList[index]['text'] = textEditorList[index].text;
    } else {
      textEditorList[index].text = scannedTextList[index].value;
      textFocusNodeList[index].requestFocus();
    }
    isEditingModeList[index].value = !isEditingModeList[index].value;
  }

  void showCustomDialog(BuildContext context, [index]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Select Image Source',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          color: blackColor,
                          size: closeIconSize,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 80,
                      height: 100,
                      child: TextButton(
                        onPressed: () async {
                          Get.back();
                          Get.find<HomeController>().isEmptyLoading.value =
                              true;
                          await getImage(ImageSource.camera, index);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(backgroundColor),
                          foregroundColor:
                              MaterialStateProperty.all(blackColor),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                size: iconSize,
                              ),
                              onPressed: () async {
                                //show loading
                                Get.back();
                                Get.find<HomeController>()
                                    .isEmptyLoading
                                    .value = true;
                                await getImage(ImageSource.camera, index);
                              },
                            ),
                            const Text(
                              'Camera',
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 80,
                      height: 100,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(backgroundColor),
                          foregroundColor:
                              MaterialStateProperty.all(blackColor),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                        ),
                        onPressed: () async {
                          Get.back();
                          Get.find<HomeController>().isEmptyLoading.value =
                              true;
                          await getImage(ImageSource.gallery, index);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.image_rounded,
                                size: iconSize,
                              ),
                              onPressed: () async {
                                Get.back();
                                Get.find<HomeController>()
                                    .isEmptyLoading
                                    .value = true;
                                await getImage(ImageSource.gallery, index);
                              },
                            ),
                            const Text(
                              'Gallery',
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
