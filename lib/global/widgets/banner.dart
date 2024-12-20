import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fieldapp_functionality/global/widgets/field_image.dart';
import 'package:fieldapp_functionality/global/widgets/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BannerType1 extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const BannerType1({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return ScalingButton(
      onTap: onTap,
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitWidth,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType2 extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  const BannerType2({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: onTap,
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitWidth,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType3 extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const BannerType3({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: onTap,
      child: FieldImage(
        imageUrl,
        fit: BoxFit.fitWidth,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType4 extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const BannerType4(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Gap(4.sp),
        ScalingButton(
          onTap: onTap,
          child: FieldImage(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: double.maxFinite,
          ),
        ),
      ],
    );
  }
}
