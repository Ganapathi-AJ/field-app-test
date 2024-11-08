import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FieldImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool isFileImage;

  const FieldImage(
    this.path, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
    this.isFileImage = false,
  });

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty || path.toLowerCase() == 'null') {
      return Image.network(
        "https://via.placeholder.com/150.png",
        fit: fit,
        height: height,
        width: width,
      );
    }
    if (isFileImage) {
      return Image.file(File(path), fit: fit, height: height, width: width);
    }

    final bool isLocalImage =
        (!path.contains("http")) && (!path.contains(".svg"));
    final bool isNetworkImage =
        path.contains("http") && (!path.contains(".svg"));
    final bool isLocalSVG = (!path.contains("http")) && path.contains(".svg");
    final bool isNetworkSVG = path.contains("http") && path.contains(".svg");
    final bool isNetworkSVGWithBase64 = path.contains("data:image/svg+xml");

    if (isNetworkSVGWithBase64) {
      final decodedBytes = base64Decode(path.split(",")[1]);
      final svgString = utf8.decode(decodedBytes);
      return SvgPicture.string(
        svgString,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else if (isLocalImage) {
      return Image.asset(path, fit: fit, height: height, width: width);
    } else if (isNetworkImage) {
      return CachedNetworkImage(
          imageUrl: path, fit: fit, height: height, width: width);
    } else if (isLocalSVG) {
      return SvgPicture.asset(
        path,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else if (isNetworkSVG) {
      return SvgPicture.network(path, fit: fit, height: height, width: width);
    } else {
      return Image.asset(
        "https://via.placeholder.com/150.png",
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}
