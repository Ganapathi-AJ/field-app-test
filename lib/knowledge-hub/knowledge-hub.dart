import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KnowledgeHub extends StatefulWidget {
  const KnowledgeHub({super.key});

  @override
  State<KnowledgeHub> createState() => _KnowledgeHubState();
}

class _KnowledgeHubState extends State<KnowledgeHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 13.0, right: 13.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for topics lessons..',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: const Row(
                  children: [
                    Text(
                      "Feature Lessons",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(color: Colors.blue, fontSize: 11),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: Colors.blue)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff1890FF),
                                Color(0xffCCE3F8),
                              ]),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              const Text(
                                "How to Navigate quickly for Store visits?",
                                style: TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.book_outlined,
                                        color: Color(0xff1890FF),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: const Row(
                  children: [
                    Text(
                      "Explore & Learn",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(color: Colors.blue, fontSize: 11),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: Colors.blue)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Heading-1'),
                                const Gap(10),
                                Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                          color: Colors.blue, width: 0.3),
                                      color: Colors.blue.withOpacity(0.1),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.0, vertical: 3),
                                      child: Text(
                                        'New',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  const Gap(5),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                          color: Colors.amber, width: 0.3),
                                      color: Colors.amber.withOpacity(0.1),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.0, vertical: 3),
                                      child: Text(
                                        'Field',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                ])
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
