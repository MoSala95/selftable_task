 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selftable_task/shared_widgets/image_not_found.dart';

class CircleNetworkImage extends StatefulWidget {
  final String image;
  final String? notFoundmage;
  final double? radius;
  final double? imageHeight;
  final double? imageWidth;
  final Color? imageColor;
  final Color? imageNotFoundBgColor;
  final BoxFit? fitImgae;
  final BorderRadius? borderRadius;
  final bool? hasntLoading;

  const CircleNetworkImage(
      {this.notFoundmage,
      required this.image,
      this.radius,
      this.imageHeight,
      this.imageWidth,
      this.imageColor,
      this.imageNotFoundBgColor,
      this.fitImgae,
      this.borderRadius,
      this.hasntLoading = false});

  @override
  State<CircleNetworkImage> createState() => _CircleNetworkImageState();
}

class _CircleNetworkImageState extends State<CircleNetworkImage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: widget.imageHeight ?? 80,
      width: widget.imageWidth ?? 80,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 15),
        child: Image.network(widget.image,

          fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => ImageNotFound(
              imageWidth: 80,
              imageHeight: 80,
            )),
      ),
    );

  }
}
