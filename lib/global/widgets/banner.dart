import 'package:cached_network_image/cached_network_image.dart';
import 'package:fieldapp_functionality/global/widgets/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerType1 extends StatelessWidget {
  final String imageUrl;
  const BannerType1({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () => print('BannerType1 tapped'),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 32.h,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType2 extends StatelessWidget {
  final String imageUrl;
  const BannerType2({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () => print('BannerType2 tapped'),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 51.5.h,
        width: double.maxFinite,
      ),
    );
  }
}

class BannerType3 extends StatelessWidget {
  final String imageUrl;
  const BannerType3({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ScalingButton(
      onTap: () => print('BannerType3 tapped'),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 81.5.h,
        width: double.maxFinite,
      ),
    );
  }
}
