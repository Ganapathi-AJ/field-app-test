import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeType1 extends StatelessWidget {
  final String greeting;
  final String name;
  WelcomeType1({required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                    child: Text(
                      "October",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text("08"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
