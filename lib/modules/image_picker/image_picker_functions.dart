import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selftable_task/ui_helpers/color_constants.dart';

class ImagePickerFunctions {
  static final ImagePicker _picker = ImagePicker();

  static openImagePicker({
    Function? onCameraPressed,
    Function? onGalleryPressed,
    Function? onGetImage,
    Function? onGetError,
    String? title,
  }) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: Get.height/2,
            margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(top: 2.5, bottom: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Choose image from",

                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          if (onCameraPressed != null) {
                            onCameraPressed();
                          } else {
                            pickOneImagePressed(
                                source: ImageSource.camera,
                                onGetImage: onGetImage ?? () {},
                                onGetError: onGetError ?? () {});
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 1, bottom: 1),
                          child: Text('Camera',
                              ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.7,
                        color: Colors.grey,
                      ),
                      InkWell(
                        onTap: () {
                          if (onGalleryPressed != null) {
                            onGalleryPressed();
                          } else {
                            pickOneImagePressed(
                                source: ImageSource.gallery,
                                onGetImage: onGetImage ?? () {},
                                onGetError: onGetError ?? () {});
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Gallery',)),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style:TextStyle(color: ColorConstants.primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static pickOneImagePressed(
      {required ImageSource source,
      required Function onGetImage,
      required Function onGetError}) async {
    try {
      XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        Get.back();
        onGetImage(pickedFile);
      }
    } catch (e) {
      onGetError(e.toString());
      print("error in get image: ${e.toString()}");
      retrieveLostData(onGetImage);
    }
  }

  static selectMultipleImages(
      {required Function onGetImages, required Function onGetErrors}) async {
    List<XFile>? _imageFileList = [];
    try {
      _imageFileList = await _picker.pickMultiImage();
      if (_imageFileList != null) {
        Get.back();
        onGetImages(_imageFileList);
      }
    } catch (e) {
      print("error in get multi image: ${e.toString()}");
      onGetErrors(e.toString());
      retrieveLostData(onGetImages);
    }
  }

  static Future<void> retrieveLostData(Function ongetImage) async {
    print("retrieveLostData");
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      print("retrieveLostData - file ${response.file}");
      ongetImage(File(response.file!.path));
    } else {
      print("response.exception.cod: ${response.exception!.code}");
      // _retrieveDataError = response.exception!.code;
    }
  }
}
