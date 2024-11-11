import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

class PageFooter extends StatefulWidget {
  const PageFooter({super.key, this.footerData});
  final Map<String, dynamic>? footerData;

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Container(
      height: sh * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 10.67.w, vertical: 3.17.h),
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
            color: Color(0x14000000),
            blurRadius: 5.98.r,
            offset: Offset(0, -1.24),
            spreadRadius: 0,
          )
        ],
      ),
      width: sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ScalingButton(
            onTap: () {
              setState(() {
                currentIndex = 0;
              });
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
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
                          color: currentIndex == 0
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
                        alignment: Alignment(0, 0.9),
                        child: Icon(
                          Symbols.home_rounded,
                          size: sh * 0.03,
                          color: currentIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 5.sp,
                      color: currentIndex == 0 ? Colors.blue : Colors.grey,
                      fontWeight: currentIndex == 0
                          ? FontWeight.w500
                          : FontWeight.w400),
                ),
              ],
            ),
          ),
          for (int i = 0;
              i < (widget.footerData?['children'] ?? []).length;
              i++)
            ScalingButton(
              onTap: () {
                if (widget.footerData?['children']?[i]?['ontap-route'] !=
                    null) {
                  Navigator.of(context).pushNamed(
                      widget.footerData?['children']?[i]?['ontap-route']);
                }
              },
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
                            color: currentIndex == i + 1
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
                          alignment: Alignment(0, 0.9),
                          child: FieldImage(
                            widget.footerData?['children'][i]['icon'] ?? '',
                            height: sh * 0.03,
                            width: sh * 0.03,
                            color: currentIndex == i + 1
                                ? Colors.blue
                                : Colors.grey.shade100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.footerData?['children'][i]['title'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: currentIndex == i + 1
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color:
                            currentIndex == i + 1 ? Colors.blue : Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
