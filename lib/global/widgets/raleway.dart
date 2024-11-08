import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:flutter/material.dart';

class RalewayType1 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  const RalewayType1(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo});

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
                  Navigator.of(context)
                      .pushNamed(children.elementAt(index)['ontap-route']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              children.elementAt(index)['imageUrl']),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(children.elementAt(index)['title'],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                              const Icon(Icons.arrow_forward_ios, size: 15)
                            ],
                          )
                        ],
                      ),
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

class RalewayType2 extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> children;
  final String? headerLogo;
  const RalewayType2(
      {super.key,
      required this.heading,
      required this.children,
      this.headerLogo});

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
                  Navigator.of(context)
                      .pushNamed(children.elementAt(index)['ontap-route']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              children.elementAt(index)['imageUrl']),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(children.elementAt(index)['title'],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                              const Icon(Icons.arrow_forward_ios, size: 15)
                            ],
                          )
                        ],
                      ),
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
