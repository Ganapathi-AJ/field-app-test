import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldapp_functionality/global/constants.dart';
import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
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
    setState(() {
      isLoading = false;
    });

    return dataList;
  }

  Widget returnTheWidget(Map mapData) {
    String widgetType = mapData['widget-type'] ?? '';
    int typeNumber = mapData['widget-number'] ?? 0;
    Widget currentWidget = const Gap(10);

    switch (widgetType) {
      case DynamicWidgetTypes.BANNER:
        if (typeNumber == 1) {
          currentWidget = BannerType1(imageUrl: mapData['imageUrl']);
        } else if (typeNumber == 2) {
          currentWidget = BannerType2(imageUrl: mapData['imageUrl']);
        } else if (typeNumber == 3) {
          currentWidget = BannerType3(imageUrl: mapData['imageUrl']);
        }
        break;
      case DynamicWidgetTypes.CAROUSEL:
        if (typeNumber == 1) {
          currentWidget = CarouselType1(imagesList: mapData['imagesList']);
        } else if (typeNumber == 2) {
          currentWidget = CarouselType2(imagesList: mapData['imagesList']);
        }
        break;
      case DynamicWidgetTypes.RALEWAY:
        if (typeNumber == 1) {
          currentWidget = RalewayType1(
              heading: mapData['title'],
              redirection: '/',
              children: mapData['children']);
        }
        break;
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                WelcomeType1(greeting: 'Good Morning', name: 'John Doe'),
                const Gap(20),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  for (int i = 0; i < layoutData.length; i++)
                    returnTheWidget(layoutData[i]),
              ],
            ),
          ),
        ));
  }
}
