import 'package:fieldapp_functionality/imageanalysis/imageanalysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'field_image.dart';
import 'scaling_button.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Map<String, dynamic>? footerData;
  final Function(int) onIndexChanged;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.footerData,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Container(
      height: sh * 0.11,
      padding: EdgeInsets.symmetric(horizontal: 10.67.w, vertical: 4.17.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.99.r),
            topRight: Radius.circular(12.99.r),
          ),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: 5.98.r,
            offset: const Offset(0, -1.24),
            spreadRadius: 0,
          )
        ],
      ),
      width: sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Symbols.home_rounded,
            label: 'Home',
            isSystemIcon: true,
          ),
          ..._buildDynamicNavItems(context),
        ],
      ),
    );
  }

  List<Widget> _buildDynamicNavItems(BuildContext context) {
    final List<dynamic> children = footerData?['children'] ?? [];
    final sh = MediaQuery.of(context).size.height;

    return List.generate(
      children.length,
      (i) => _buildNavItem(
        context,
        index: i + 1,
        icon: children[i]['icon'] ?? '',
        label: children[i]['title'] ?? '',
        isSystemIcon: false,
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required dynamic icon,
    required String label,
    required bool isSystemIcon,
  }) {
    final sh = MediaQuery.of(context).size.height;

    return ScalingButton(
      onTap: () => onIndexChanged(index),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                bottom: -sh * 0.07 / 3,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: sh * 0.06,
                  width: sh * 0.06,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                width: sh * 0.07,
                height: sh * 0.05,
                child: Align(
                  alignment: const Alignment(0, 0.9),
                  child: isSystemIcon
                      ? Icon(
                          icon,
                          size: sh * 0.03,
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                        )
                      : FieldImage(
                          icon,
                          height: sh * 0.03,
                          width: sh * 0.03,
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                        ),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 5.sp,
              color: currentIndex == index ? Colors.blue : Colors.grey,
              fontWeight:
                  currentIndex == index ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar2 extends StatelessWidget {
  final int currentIndex;
  final Map<String, dynamic>? footerData;
  final Function(int) onIndexChanged;

  const BottomBar2({
    super.key,
    required this.currentIndex,
    required this.footerData,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: sh * 0.09,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r)),
          shadows: [
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 5.98.r,
              offset: const Offset(0, -1.24),
              spreadRadius: 0,
            )
          ],
        ),
        width: sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context,
              index: 0,
              icon: Symbols.home_rounded,
              label: 'Home',
              isSystemIcon: true,
            ),
            ..._buildDynamicNavItems(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDynamicNavItems(BuildContext context) {
    final List<dynamic> children = footerData?['children'] ?? [];
    final sh = MediaQuery.of(context).size.height;

    return List.generate(
      children.length,
      (i) => _buildNavItem(
        context,
        index: i + 1,
        icon: children[i]['icon'] ?? '',
        label: children[i]['title'] ?? '',
        isSystemIcon: false,
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required dynamic icon,
    required String label,
    required bool isSystemIcon,
  }) {
    final sh = MediaQuery.of(context).size.height;

    return ScalingButton(
      onTap: () => onIndexChanged(index),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color:
                      currentIndex == index ? primaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.sp),
                  child: Align(
                    alignment: const Alignment(0, 0.9),
                    child: isSystemIcon
                        ? Icon(
                            icon,
                            size: sh * 0.03,
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                          )
                        : FieldImage(
                            icon,
                            height: sh * 0.03,
                            width: sh * 0.03,
                            color: currentIndex == index
                                ? Colors.blue
                                : Colors.grey,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 5.sp,
              color: currentIndex == index ? Colors.blue : Colors.grey,
              fontWeight:
                  currentIndex == index ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
