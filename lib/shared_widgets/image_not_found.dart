
import 'package:flutter/material.dart';
 import 'package:selftable_task/ui_helpers/assets_constants.dart';

class ImageNotFound extends StatelessWidget {
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;
  final String? image;

  const ImageNotFound(
      {Key? key,
      this.imageWidth,
      this.imageHeight,
      this.borderRadius,
      this.image,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight ?? 250,
      width: imageWidth ?? 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
          border:
              Border.all(color: Colors.grey, width: 1),
          color: Colors.grey),
      child: Center(
        child: Image.asset(
          image ?? AssetsConstants.imageNotFound,
          //fit: BoxFit.cover,
        ),
      ),
    );
  }
}
