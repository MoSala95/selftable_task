// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selftable_task/ui_helpers/color_constants.dart';

class BuildProfilePicture extends StatelessWidget {
  XFile? pickedImage;
  Function() onTap;

  BuildProfilePicture({required this.onTap, this.pickedImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (pickedImage != null)
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                image: DecorationImage(
                  image: FileImage(File(pickedImage?.path ?? "")),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.15), BlendMode.darken),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(70),
                ),
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.primaryColor.withOpacity(0.5),
                      blurRadius: 7),
                ],
              ),
            )
          else
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(70),
                ),
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.primaryColor.withOpacity(0.5),
                      blurRadius: 7),
                ],
              ),
            ),

          Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
