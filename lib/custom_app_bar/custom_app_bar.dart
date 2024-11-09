import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffEDF1F7),
      // surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
      // elevation: 2,
      shadowColor: Colors.black26,
      leadingWidth: 90,
      centerTitle: true,
      leading: Navigator.canPop(context)
          ? Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 17,
                    color: Color(0xFF1890FF),
                  ),
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xFF1890FF),
                    fontSize: 18,
                  ),
                )
              ],
            )
          : SizedBox(),
      iconTheme: IconThemeData(size: 37),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [],
    );
  }
}
