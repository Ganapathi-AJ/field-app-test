import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldapp_functionality/global/widgets/raleway.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fieldapp_functionality/global/widgets/welcome.dart' as wd;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List<Map<String, dynamic>> layoutData = [];

  fetchData() async {
    List<Map<String, dynamic>> dataList = [];

    try {
      // Reference to Firestore collection
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection('homepage-layout')
          .doc('client1')
          .collection('children');

      // Fetch data from the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Map the document data to a list
      dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      layoutData = dataList;
    } catch (e) {
      print("Error fetching data: $e");
    }
    print('layoutData:' + layoutData.toString());

    return dataList;
  }

  Widget returnTheWidget(Map mapData) {
    String widgetType = mapData['widget-type'];
    int typeNumber = mapData['widget-number'];
    Widget currentWidget = Gap(10);

    if (widgetType == 'raleway') {
      if (typeNumber == 1) {
        currentWidget = RalewayType1(
            heading: mapData['title'],
            redirection: '/',
            children: mapData['children']);
      }
    }
    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    Map _firstWidgetMap = layoutData.firstWhere(
      (element) => element['order'] == 1,
    );
    return Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Gap(20),
                wd.WelcomeType1(greeting: 'Good Evening', name: 'John Doe'),
                RalewayType1(
                  heading: 'Hi',
                  redirection: '/ds',
                  children: [
                    {
                      'title': 'Inventory Management',
                      'imageUrl':
                          'https://lh5.googleusercontent.com/y4yP2D0a3H1jPA2IaocvGaM93Ou3i4-ZTNPDMJLQJeGBxJpTcilS6rpn1bbDFX51NTG5731vPuZwxf52Yr1dEwxcBpktlGbfirJ36e1eExKEIE0nJtjaxYm2rGqIbGctJCJ7Zn4B'
                    },
                    {
                      'title': 'Inventory Management',
                      'imageUrl':
                          'https://lh5.googleusercontent.com/y4yP2D0a3H1jPA2IaocvGaM93Ou3i4-ZTNPDMJLQJeGBxJpTcilS6rpn1bbDFX51NTG5731vPuZwxf52Yr1dEwxcBpktlGbfirJ36e1eExKEIE0nJtjaxYm2rGqIbGctJCJ7Zn4B'
                    }
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
