import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:fieldapp_functionality/global/svg_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class WelcomeType1 extends StatelessWidget {
  final String greeting;
  final String name;
  WelcomeType1({required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return SizedBox(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(name,
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700)),
            ],
          ),
          const Spacer(),
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000).withOpacity(0.01),
                        blurRadius: 4.46.r,
                        offset: Offset(0, 0.46),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: FieldImage(SvgStrings.calenderSvg,
                      width: 0.2.sw, height: 0.2.sw),
                ),
                Positioned(
                  top: 0.035.sw,
                  child: Text(
                    DateFormat.MMMM().format(DateTime.now()),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 0.022.sw,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                  bottom: 0.05.sw,
                  child: Text(
                    DateFormat('dd').format(DateTime.now()),
                    style: TextStyle(color: Colors.black, fontSize: 0.05.sw),
                  ),
                )
              ],
            ),
          )
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Column(
          //     children: [
          //       Container(
          //         decoration: const BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             topRight: Radius.circular(10),
          //           ),
          //         ),
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
          //           child: Text(
          //             "October",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.all(13.0),
          //         child: Text("08"),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
