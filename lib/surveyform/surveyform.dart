import 'package:fieldapp_functionality/custom_app_bar/custom_app_bar.dart';
import 'package:fieldapp_functionality/surveyform/surveyform1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

// final surveyForms = {
//   "forms": ["Survey for performance"],
//   "Survey for performance": {
//     "title": "Survey for performance",
//     "description": "To understand our performance across different verticals.",
//     "questions": [
//       {"title": "Rank our efforts", "type": "short", "required": true},
//       {
//         "title": "Anymore pointers we shall note?",
//         "type": "short",
//         "required": true
//       },
//     ]
//   }
// };

class SurveyForm extends StatefulWidget {
  const SurveyForm({super.key});

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  // bool isFormFilled = true;

  final surveyForms = [
    {
      "formsId": 21,
      "title": "Survey for performance",
      "description":
          "To understand our performance across different verticals.",
      "isFormFilled": false,
    },
    {
      "formsId": 22,
      "title": "Survey for sales",
      "description":
          "To understand our performance across different verticals.",
      "isFormFilled": true,
    },
    {
      "formsId": 23,
      "title": "Market Insights",
      "description":
          "To understand our performance across different verticals.",
      "isFormFilled": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F7),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Symbols.arrow_back_ios,
                              size: 17,
                              color: const Color(0xff4285F4),
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 15,
                                color: const Color(0xff4285F4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text("Survey Forms",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      const SizedBox(),
                      const SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: surveyForms.length,
                    itemBuilder: (context, index) {
                      final form = surveyForms[index];
                      bool isFormFilled = form["isFormFilled"] as bool;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  form['title'].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Gap(14),
                            GestureDetector(
                              onTap: () async {
                                if (!isFormFilled) {
                                  bool? formFilled =
                                      await Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                    return FormScreen(
                                      formId: form['formsId'] as int,
                                    );
                                  }));
                                  if (formFilled != null &&
                                      formFilled == true) {
                                    setState(() {
                                      surveyForms[index]["isFormFilled"] = true;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isFormFilled
                                      ? Color(0xFFEAFFED)
                                      : Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 9),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        isFormFilled
                                            ? "Form Filled"
                                            : "Fill the form",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: isFormFilled
                                              ? Color(0xff006617)
                                              : Colors.blue,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      isFormFilled
                                          ? Icon(Icons.check_circle,
                                              size: 20,
                                              color: Color(0xff006617))
                                          : Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                              color: Colors.blue,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
