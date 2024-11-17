import 'package:cached_network_image/cached_network_image.dart';
import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RalewayType1 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  final Function onTap;
  const RalewayType1(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (headerLogo != null) Image.network(headerLogo!, height: 20),
            const SizedBox(width: 5),
            Text(
              heading,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.blue, fontSize: 11),
                )),
          ],
        ),
        
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return ScalingButton(
                onTap: () {
                  onTap(children.elementAt(index)['ontap-route'],
                      children.elementAt(index)['url']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                      height: 120,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       image: NetworkImage(
                      //           children.elementAt(index)['imageUrl']),
                      //       fit: BoxFit.fitHeight),
                      // ),
                      child: CachedNetworkImage(
                        imageUrl: children.elementAt(index)['imageUrl'],
                        fit: BoxFit.fitHeight,
                      )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RalewayType2 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  final Function onTap;
  const RalewayType2(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (headerLogo != null) Image.network(headerLogo!, height: 20),
            const SizedBox(width: 5),
            Text(
              heading,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.blue, fontSize: 11),
                )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return ScalingButton(
                onTap: () {
                  onTap(children.elementAt(index)['ontap-route'],
                      children.elementAt(index)['url']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: children.elementAt(index)['imageUrl'],
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RalewayType3 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  final Function onTap;
  const RalewayType3(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.017.sh),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
            Colors.blue.shade50,
          ],
          stops: [0.0, 0.4, 1.0],
        ),
        borderRadius: BorderRadius.circular(5.57.r),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (headerLogo != null) Image.network(headerLogo!, height: 20),
              const SizedBox(width: 5),
              Text(
                heading,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 8,
                    color: Colors.black,
                  )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              height: 0.1.sh,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < children.length; i++)
                      ScalingButton(
                        onTap: () {
                          onTap(children.elementAt(i)['ontap-route'],
                              children.elementAt(i)['url']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x07000000),
                                  blurRadius: 4.15,
                                  offset: Offset(0, 0.44),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: children.elementAt(i)['imageUrl'],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      )
                  ])),
        ],
      ),
    );
  }
}

class RalewayType4 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  final Function onTap;
  const RalewayType4(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.017.sh),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
            Colors.blue.shade50,
          ],
          stops: [0.0, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(5.57.r),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (headerLogo != null) Image.network(headerLogo!, height: 20),
              const SizedBox(width: 5),
              Text(
                heading,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 8,
                    color: Colors.black,
                  )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              height: 0.125.sh,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return ScalingButton(
                    onTap: () {
                      onTap(children.elementAt(index)['ontap-route'],
                          children.elementAt(index)['url']);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 0.04.sw),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x07000000),
                              blurRadius: 4.15,
                              offset: Offset(0, 0.44),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: children.elementAt(index)['imageUrl'],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
