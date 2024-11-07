import 'package:flutter/material.dart';

class RalewayType1 extends StatelessWidget {
  final String heading;
  final String redirection;
  final List children;
  RalewayType1(
      {required this.heading,
      required this.redirection,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
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
              return Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(children.elementAt(index)['imageUrl']),
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
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400)),
                            Icon(Icons.arrow_forward_ios, size: 15)
                          ],
                        )
                      ],
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
