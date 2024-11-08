import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final surveyForms = {
  "forms": ["Survey for performance"],
  "Survey for performance": {
    "title": "Survey for performance",
    "description": "To understand our performance across different verticals.",
    "questions": [
      {"title": "Rank our efforts", "type": "short", "required": true},
      {
        "title": "Anymore pointers we shall note?",
        "type": "short",
        "required": true
      },
    ]
  }
};

class SurveyForm extends StatefulWidget {
  const SurveyForm({super.key});

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        title: const Text('Survey Form'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/noforms.png',
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const FormScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xff1890FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Now',
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        surfaceTintColor: Colors.transparent,
        title: const Text('Survey Form'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            hintText: "   Enter",
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
                            hintText: "   Form Description",
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
                            hintText: "   Untitled Question",
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
                      const Gap(10),
                      Column(
                        children: [
                          RadioListTile(
                            title: const Text('Untitled 1'),
                            value: 'Untitled 1',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          RadioListTile(
                            title: const Text('Untitled 2'),
                            value: 'Untitled 2',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          RadioListTile(
                            title: const Text('Untitled 3'),
                            value: 'Untitled 3',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          const RadioListTile(
                            title: Text(
                              'Add Option',
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 'Untitled 4',
                            groupValue: null,
                            onChanged: null,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Required',
                                style: TextStyle(fontSize: 16),
                              ),
                              Switch(
                                value: false,
                                onChanged: (value) {},
                                activeTrackColor: Colors.black,
                                inactiveTrackColor: Colors.grey.shade300,
                                activeColor: Colors.blue,
                                trackOutlineColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                              ),
                              Icon(Icons.copy_rounded)
                            ],
                          )
                        ],
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
                            hintText: "   Untitled Question",
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
                      const Gap(10),
                      Column(
                        children: [
                          RadioListTile(
                            title: const Text('Untitled 1'),
                            value: 'Untitled 1',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          RadioListTile(
                            title: const Text('Untitled 2'),
                            value: 'Untitled 2',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          RadioListTile(
                            title: const Text('Untitled 3'),
                            value: 'Untitled 3',
                            groupValue: null,
                            onChanged: (value) {},
                          ),
                          const RadioListTile(
                            title: Text(
                              'Add Option',
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 'Untitled 4',
                            groupValue: null,
                            onChanged: null,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Required',
                                style: TextStyle(fontSize: 16),
                              ),
                              Switch(
                                value: true,
                                onChanged: (value) {},
                                inactiveTrackColor: Colors.grey.shade300,
                                activeColor: Colors.blue,
                                trackOutlineColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                              ),
                              Icon(Icons.copy_rounded)
                            ],
                          )
                        ],
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
                            hintText: "   Untitled Question",
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
                      const Gap(10),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const SureveyFormNext();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: Text("Save & Next",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),

                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Handle save action
                    //   },
                    //   child: const Text('Save'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pop(ctx);
                    //   },
                    //   child: const Text('Cancel'),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SureveyFormNext extends StatefulWidget {
  const SureveyFormNext({super.key});

  @override
  State<SureveyFormNext> createState() => _SureveyFormNextState();
}

class _SureveyFormNextState extends State<SureveyFormNext> {
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Survey for performance",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                        Icon(Icons.delete_outline)
                      ],
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const FinalForm();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "View Results",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (ctx){
              //   return const FormScreen();
              // }));
            },
            child: Text("Create New", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

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
                        child: TextField(
                          controller: TextEditingController(text: "  Nah!"),
                          decoration: InputDecoration(
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
