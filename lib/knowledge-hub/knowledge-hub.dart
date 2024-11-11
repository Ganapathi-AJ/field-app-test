import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

const lessons = [
  "How to Navigate quickly for Store visits?",
  "Using Invoice scanning & adding bills to the system.",
];

const topics = [
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.auto_stories_rounded,
  },
  {
    "titel": "Learn Pixel 9 product details",
    "desc":
        "Google has dropped their Pixel 9 latest features quickly learn them",
    "icon": Symbols.stay_current_landscape_rounded,
  },
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.support_agent_rounded,
  },
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.auto_stories_rounded,
  },
  {
    "titel": "Learn Pixel 9 product details",
    "desc":
        "Google has dropped their Pixel 9 latest features quickly learn them",
    "icon": Symbols.stay_current_landscape_rounded,
  },
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.support_agent_rounded,
  },
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.auto_stories_rounded,
  },
  {
    "titel": "Learn Pixel 9 product details",
    "desc":
        "Google has dropped their Pixel 9 latest features quickly learn them",
    "icon": Symbols.stay_current_landscape_rounded,
  },
  {
    "titel": "Learn how to deal with customers",
    "desc": "To become the best retailer",
    "icon": Symbols.support_agent_rounded,
  }
];

class KnowledgeHub extends StatefulWidget {
  const KnowledgeHub({super.key});

  @override
  State<KnowledgeHub> createState() => _KnowledgeHubState();
}

class _KnowledgeHubState extends State<KnowledgeHub> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 246, 247, 250),
          iconTheme: IconThemeData(
            color: const Color.fromRGBO(54, 158, 255, 1),
          ),
          title: Text('Knowledge Hub',
              style: TextStyle(
                fontSize: 0.043 * sw,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffF6F7FA),
        body: SingleChildScrollView(
          child: SafeArea(
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
                            Symbols.search,
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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const Text(
                        "Feature Lessons",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const FeatureLessons()));
                        },
                        child: const Row(
                          children: [
                            Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Symbols.arrow_forward_ios,
                                size: 12, color: Colors.blue)
                          ],
                        ),
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
                          width: 70.w,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/imgs/${index % 2 == 0 ? 1 : 2}.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 70.w,
                                  height: 40.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.0, 0.9],
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "How to Navigate quickly for Store visits?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 5.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const Text(
                        "Explore & Learn",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ExploreLearn()));
                        },
                        child: const Row(
                          children: [
                            Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Symbols.arrow_forward_ios,
                                size: 12, color: Colors.blue)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (ctx, index) {
                      final topic = topics[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.sp, vertical: 2.sp),
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
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Icon(
                                      topic['icon'] as IconData,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      topic['titel'].toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      topic['desc'].toString(),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    const Gap(10),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded, size: 7.sp),
                              Gap(4.sp)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class FeatureLessons extends StatefulWidget {
  const FeatureLessons({super.key});

  @override
  State<FeatureLessons> createState() => _FeatureLessonsState();
}

class _FeatureLessonsState extends State<FeatureLessons> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 246, 247, 250),
          iconTheme: IconThemeData(
            color: const Color.fromRGBO(54, 158, 255, 1),
          ),
          //iconTheme: IconThemeData(color: const Color.fromRGBO(54, 158, 255, 1), ),
          title: Text('Feature Lessons',
              style: TextStyle(
                fontSize: 0.04 * sw,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffF6F7FA),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 3.0, left: 13.0, right: 13.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for topics lessons..',
                    suffixIcon: Icon(
                      Symbols.search,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (ctx, index) {
                final topic = topics[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
                  child: Container(
                    height: 50.sp,
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
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 45.w,
                              height: 45.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.sp),
                                    child: Image.asset(
                                      'assets/imgs/${index % 2 == 0 ? 1 : 2}.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 2.sp,
                                    bottom: 2.sp,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Symbols.play_lesson,
                                          size: 8.sp,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Gap(3.sp),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      topic['titel'].toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      topic['desc'].toString(),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    const Gap(10),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ArticleLesson()));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Learn More",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 6.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Gap(3.sp),
                                          Icon(Symbols.arrow_forward_ios,
                                              size: 5.sp, color: Colors.blue)
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ])));
  }
}

class ExploreLearn extends StatefulWidget {
  const ExploreLearn({super.key});

  @override
  State<ExploreLearn> createState() => _ExploreLearnState();
}

class _ExploreLearnState extends State<ExploreLearn> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 246, 247, 250),
          iconTheme: IconThemeData(
            color: const Color.fromRGBO(54, 158, 255, 1),
          ),
          //iconTheme: IconThemeData(color: const Color.fromRGBO(54, 158, 255, 1), ),
          title: Text('Feature Lessons',
              style: TextStyle(
                fontSize: 0.04 * sw,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffF6F7FA),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 3.0, left: 13.0, right: 13.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for topics lessons..',
                      suffixIcon: Icon(
                        Symbols.search,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (ctx, index) {
                  final topic = topics[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ArticelLearn()));
                      },
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
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Icon(
                                    topic['icon'] as IconData,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topic['titel'].toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    topic['desc'].toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                  const Gap(10),
                                ],
                              ),
                            ),
                            Gap(4.sp)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        )));
  }
}

class ArticleLesson extends StatefulWidget {
  const ArticleLesson({super.key});

  @override
  State<ArticleLesson> createState() => _ArticleLessonState();
}

class _ArticleLessonState extends State<ArticleLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F7FA),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Column(
            children: [
              Image.asset('assets/imgs/1.png'),
              Gap(5.sp),
              Row(
                children: [
                  Text("Navigate Quickly",
                      style: TextStyle(
                          fontSize: 8.sp, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.green),
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 2.sp),
                      child: Text(
                        "5 min",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 4.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              Gap(5.sp),
              Text(
                  "Navigating the store quickly is essential as you would have to take the customer around every products they want to see and you should know the shortest way so they dont get tired.",
                  style: TextStyle(
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600)),
              Gap(5.sp),
              Text(
                  "Navigating the store quickly is essential as you would have to take the customer around every products they want to see and you should know the shortest way so they dont get tired. Navigating the store quickly is essential as you wouldhave to take the customer around every productsthey want to see and you should know the shortestway so they dont get tired.Navigating the store quickly is essential as you would have to take the customer around every products they want to see and you should know the shortest way so they dont get tired.Navigating the store quickly is essential as you would have to take the customer around every products they want to see and you should know the shortest way so they dont get tired. they want to see and you should know the shortest way so they dont get tired.",
                  style: TextStyle(
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600)),
              Gap(8.sp),
              Row(
                children: [
                  Text("More Similar Articles",
                      style: TextStyle(
                          fontSize: 6.sp, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ExploreLearn()));
                    },
                    child: Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 4.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Symbols.arrow_forward_ios,
                            size: 4.sp, color: Colors.blue)
                      ],
                    ),
                  )
                ],
              ),
              Gap(5.sp),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                        width: 70.w,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/imgs/${index % 2 == 0 ? 1 : 2}.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 70.w,
                                height: 40.sp,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 0.9],
                                    colors: [
                                      Colors.white.withOpacity(0.1),
                                      Colors.white.withOpacity(1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "How to Navigate quickly for Store visits?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 5.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticelLearn extends StatefulWidget {
  const ArticelLearn({super.key});

  @override
  State<ArticelLearn> createState() => ArticelLearnState();
}

class ArticelLearnState extends State<ArticelLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F7FA),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blue.shade50),
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.sp),
                    Icon(
                      Symbols.auto_stories_rounded,
                      color: Colors.blue.shade600,
                      size: 20.sp,
                    ),
                    Gap(4.sp),
                    Text(
                      "Dealing with the customers",
                      style: TextStyle(
                          color: Colors.blue.shade500,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Gap(2.sp),
                    Text(" Wednesday . 9 Nov, 2024",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 4.sp,
                            fontWeight: FontWeight.w300)),
                    Gap(4.sp),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Interaction",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap(2.sp),
                  Text(
                    "• Active Listening: Pay close attention to customer concerns and questions.\n"
                    "• Empathy: Understand and respond to customer emotions.\n"
                    "• Clear Communication: Speak clearly and concisely, avoiding technical jargon.\n"
                    "• Patience: Remain calm and patient, especially in stressful situations.\n"
                    "• Positive Attitude: Maintain a friendly and helpful demeanor.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w300),
                  ),
                  Gap(4.sp),
                  Text(
                    "Problem-Solving",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap(2.sp),
                  Text(
                    "• Identify the Issue: Pinpoint the root cause of the problem.\n"
                    "• Offer Solutions: Provide practical and timely solutions.\n"
                    "• Follow-Up: Ensure the issue is resolved and customer satisfaction is achieved.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w300),
                  ),
                  Gap(4.sp),
                  Text(
                    "Building Relationships",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap(2.sp),
                  Text(
                    "• Personalization: Use the customer's name and reference past interactions.\n"
                    "• Value their Time: Be efficient and respectful of their schedule.\n"
                    "• Build Trust: Be honest, reliable, and transparent.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w300),
                  ),
                  Gap(4.sp),
                  Text(
                    "Additional Tips",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap(2.sp),
                  Text(
                    "• Professionalism: Dress appropriately and maintain a clean appearance.\n"
                    "• Time Management: Prioritize tasks and manage your time effectively.\n"
                    "• Conflict Resolution: Handle disagreements calmly and diplomatically.\n"
                    "• Continuous Learning: Stay updated on industry trends and product knowledge.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
