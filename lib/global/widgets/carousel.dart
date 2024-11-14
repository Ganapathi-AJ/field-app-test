import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselType1 extends StatefulWidget {
  const CarouselType1(
      {super.key,
      required this.children,
      this.autoPlay = true,
      required this.onTap});
  final List<Map<String, dynamic>> children;
  final bool autoPlay;
  final Function onTap;

  @override
  State<CarouselType1> createState() => _CarouselType1State();
}

class _CarouselType1State extends State<CarouselType1> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.autoPlay) {
      Timer.periodic(const Duration(seconds: 10), (Timer timer) {
        if (currentPage < widget.children.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 0.15.sh,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              final i = widget.children[index];
              return ScalingButton(
                onTap: () {
                  widget.onTap(i['ontap-route'], i['url']);
                },
                child: CachedNetworkImage(
                  imageUrl: i['imageUrl'] ?? '',
                  height: 0.15.sh,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: i == currentPage ? 9.2.w : 2.5.h,
                height: 2.5.h,
                margin: i == widget.children.length - 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(right: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  color: currentPage == i
                      ? Colors.blue
                      : Colors.blue.withOpacity(0.2),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class CarouselType2 extends StatefulWidget {
  const CarouselType2(
      {super.key,
      required this.children,
      this.autoPlay = true,
      required this.onTap});
  final List<Map<String, dynamic>> children;
  final bool autoPlay;
  final Function onTap;

  @override
  State<CarouselType2> createState() => _CarouselType2State();
}

class _CarouselType2State extends State<CarouselType2> {
  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      goToNext();
    });
  }

  void goToNext() {
    if (!widget.autoPlay) {
      return;
    }
    if (currentPage < widget.children.length - 1) {
      currentPage++;
    } else {
      currentPage = 0;
    }
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    if (currentPage > 0) {
                      setState(() {
                        currentPage--;
                        timer.cancel();
                        timer = Timer.periodic(const Duration(seconds: 3),
                            (Timer t) {
                          goToNext();
                        });
                      });
                    }
                  } else {
                    if (currentPage < widget.children.length - 1) {
                      setState(() {
                        currentPage++;
                        timer.cancel();
                        timer = Timer.periodic(const Duration(seconds: 3),
                            (Timer t) {
                          goToNext();
                        });
                      });
                    }
                  }
                },
                onTap: () {
                  if (currentPage == i) {
                    widget.onTap(widget.children[i]['ontap-route'],
                        widget.children[i]['url']);
                  }
                  setState(() {
                    currentPage = i;
                    timer.cancel();
                    timer =
                        Timer.periodic(const Duration(seconds: 3), (Timer t) {
                      goToNext();
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: i == currentPage
                      ? MediaQuery.of(context).size.width * 0.75
                      : i == 1
                          ? MediaQuery.of(context).size.width * 0.15
                          : i == currentPage - 1
                              ? MediaQuery.of(context).size.width * 0.15
                              : 0.h,
                  height: 65.h,
                  margin: i == currentPage
                      ? i == 0
                          ? EdgeInsets.only(right: 4.5.w)
                          : EdgeInsets.only(left: 4.5.w)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(7.5.r)),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.children[i]['imageUrl'] ?? '',
                        height: 64.h,
                        width: 121.w,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: i == currentPage ? 9.2.w : 2.5.h,
                height: 2.5.h,
                margin: i == widget.children.length - 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(right: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  color: currentPage == i
                      ? Colors.blue
                      : Colors.blue.withOpacity(0.2),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class CarouselType3 extends StatefulWidget {
  const CarouselType3(
      {super.key,
      required this.children,
      this.autoPlay = true,
      required this.onTap});
  final List<Map<String, dynamic>> children;
  final bool autoPlay;
  final Function onTap;

  @override
  State<CarouselType3> createState() => _CarouselType3State();
}

class _CarouselType3State extends State<CarouselType3> {
  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      goToNext();
    });
  }

  void goToNext() {
    if (!widget.autoPlay) {
      return;
    }
    if (currentPage < widget.children.length - 1) {
      currentPage++;
    } else {
      currentPage = 0;
    }
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    if (currentPage > 0) {
                      setState(() {
                        currentPage--;
                        timer.cancel();
                        timer = Timer.periodic(const Duration(seconds: 3),
                            (Timer t) {
                          goToNext();
                        });
                      });
                    }
                  } else {
                    if (currentPage < widget.children.length - 1) {
                      setState(() {
                        currentPage++;
                        timer.cancel();
                        timer = Timer.periodic(const Duration(seconds: 3),
                            (Timer t) {
                          goToNext();
                        });
                      });
                    }
                  }
                },
                onTap: () {
                  if (currentPage == i) {
                    widget.onTap(widget.children[i]['ontap-route'],
                        widget.children[i]['url']);
                  }
                  setState(() {
                    currentPage = i;
                    timer.cancel();
                    timer =
                        Timer.periodic(const Duration(seconds: 3), (Timer t) {
                      goToNext();
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: i == currentPage
                      ? MediaQuery.of(context).size.width * 0.85
                      : i == 1
                          ? MediaQuery.of(context).size.width * 0.15
                          : i == currentPage - 1
                              ? MediaQuery.of(context).size.width * 0.15
                              : 0.h,
                  height: 60.h,
                  margin: i == currentPage
                      ? i == 0
                          ? EdgeInsets.only(right: 4.5.w)
                          : EdgeInsets.only(left: 4.5.w)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(7.5.r)),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.children[i]['imageUrl'] ?? '',
                        height: 64.h,
                        width: 136.64.w,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: i == currentPage ? 9.2.w : 2.5.h,
                height: 2.5.h,
                margin: i == widget.children.length - 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(right: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  color: currentPage == i
                      ? Colors.blue
                      : Colors.blue.withOpacity(0.2),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
