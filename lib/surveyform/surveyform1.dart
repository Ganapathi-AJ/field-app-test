import 'package:fieldapp_functionality/surveyform/surveyform.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FormScreen extends StatefulWidget {
  final int formId;
  FormScreen({super.key, required this.formId});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? selectedValue1;
  String? selectedValue2;
  final selectedOptions = <String>{};

  final surveyForms = [
    {
      "formsId": 21,
      "title": "Survey for performance",
      "description":
          "To understand our performance across different verticals.",
      "isFormFilled": false,
      "questions": [
        {
          "title":
              "Are the prices displayed as per the suggested retail price?",
          "type": "radio",
          "options": ["Yes", "No"],
        },
        {
          "title": "What does 'B2B' stand for in sales terminology?",
          "type": "radio",
          "options": [
            "Buyer to Business",
            "Business to Buyer",
            "Business to Business"
          ],
        },
        {
          "title": "Which sales strategies have been effective?",
          "type": "checkbox",
          "options": ["Discount Offers", "Cold Calling", "Email Marketing"],
        },
        {
          "title": "Please provide any additional comments.",
          "type": "text",
        }
      ]
    },
    {
      "formsId": 23,
      "title": "Market Insights",
      "description":
          "Gather insights on market trends and customer preferences.",
      "isFormFilled": false,
      "questions": [
        {
          "title": "How often do customers inquire about product quality?",
          "type": "radio",
          "options": ["Frequently", "Occasionally", "Rarely"],
        },
        {
          "title": "Which marketing channels are most effective?",
          "type": "checkbox",
          "options": ["Social Media", "Email Campaigns", "In-Store Promotions"],
        },
        {
          "title": "How would you rate the current customer demand?",
          "type": "radio",
          "options": ["High", "Moderate", "Low"],
        },
        {
          "title": "Any additional feedback on market trends?",
          "type": "text",
        }
      ]
    },
  ];

  Map<dynamic, dynamic> selectedForm = {};
  final Map<String, dynamic> answers = {};

  @override
  void initState() {
    selectedForm = surveyForms.firstWhere((e) => e['formsId'] == widget.formId);
    super.initState();
  }

  Widget _buildQuestion(Map question) {
    switch (question['type']) {
      case 'radio':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(question['title']),
              ),
              ...question['options']
                  .map<Widget>((option) => RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: answers[question['title']],
                        onChanged: (value) {
                          setState(() {
                            answers[question['title']] = value;
                          });
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      case 'checkbox':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(question['title']),
              ),
              ...question['options']
                  .map<Widget>((option) => CheckboxListTile(
                        title: Text(option),
                        value: answers[question['title']]?.contains(option) ??
                            false,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          setState(() {
                            answers[question['title']] ??= [];
                            if (isChecked!) {
                              answers[question['title']].add(option);
                            } else {
                              answers[question['title']].remove(option);
                            }
                          });
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      case 'text':
      default:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(question['title']),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (text) {
                    answers[question['title']] = text;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your answer",
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(selectedForm['title']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              height: 610,
              child: ListView(
                children: [
                  ...selectedForm['questions']
                      .map<Widget>((question) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: _buildQuestion(question),
                          ))
                      .toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        child: const Text(
                          "Save & Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
