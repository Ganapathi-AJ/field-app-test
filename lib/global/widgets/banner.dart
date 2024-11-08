import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fieldapp_functionality/global/widgets/field_image.dart';
import 'package:fieldapp_functionality/global/widgets/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerType1 extends StatelessWidget {
  final String imageUrl;
  final String redirection;
  const BannerType1(
      {super.key, required this.imageUrl, required this.redirection});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return ScalingButton(
      onTap: () {
        Navigator.of(context).pushNamed(redirection);
      },
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitHeight,
        height: 32.h,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType2 extends StatelessWidget {
  final String imageUrl;
  final String redirection;
  const BannerType2(
      {super.key, required this.imageUrl, required this.redirection});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () {
        Navigator.of(context).pushNamed(redirection);
      },
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitHeight,
        height: 51.5.h,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType3 extends StatelessWidget {
  final String imageUrl;
  final String redirection;

  const BannerType3(
      {super.key, required this.imageUrl, required this.redirection});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () {
        Navigator.of(context).pushNamed(redirection);
      },
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitHeight,
        height: 81.5.h,
        width: double.maxFinite,
      ),
    );
  }
}
