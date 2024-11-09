import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinalForm extends StatefulWidget {
  const FinalForm({super.key});

  @override
  State<FinalForm> createState() => _FinalFormState();
}

class _FinalFormState extends State<FinalForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text('Survey Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Form Title & Description",
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "   Survey for performance",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText:
                                "   To understand our performance across different verticals.",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "   Rank our efforts",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Center(
                        child: SizedBox(
                            width: 160, child: Image.asset("assets/pie.png")),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: 200,
                        child: Center(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "   Multiple Choice",
                                hintStyle: const TextStyle(
                                    color: Color(0xff74787E),
                                    fontWeight: FontWeight.w300),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              items: const [],
                              value: null,
                              onChanged: (val) {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "   Any more pointers we shall note?",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: TextField(
                          controller: TextEditingController(
                              text: "  Work More on english"),
                          decoration: const InputDecoration(
                            hintText: "   Survey for performance",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffF8F8F8)),
                        child: TextField(
                          controller: TextEditingController(text: "  Nah!"),
                          decoration: const InputDecoration(
                            hintText: "   Survey for performance",
                            hintStyle: TextStyle(
                                color: Color(0xff74787E),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: 200,
                        child: Center(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "   Short Ans Type",
                                hintStyle: const TextStyle(
                                    color: Color(0xff74787E),
                                    fontWeight: FontWeight.w300),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              items: const [],
                              value: null,
                              onChanged: (val) {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
            ]))),
      ),
    );
  }
}
