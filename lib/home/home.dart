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
  Widget pageFooter = const SizedBox();
  Widget pageHeader = const Gap(10);

  Map<String, dynamic>? headerData;
  Map<String, dynamic>? footerData;
  final List<Map<String, dynamic>> layoutData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final List<Map<String, dynamic>> dataList = [];

    try {
      final CollectionReference collectionRef = FirebaseFirestore.instance
          .collection('homepage-layout')
          .doc('client1')
          .collection('children');

      final QuerySnapshot querySnapshot = await collectionRef.get();

      dataList.addAll(querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          return data;
        }
        return <String, dynamic>{};
      }));

      final footerItems = dataList
          .where(
            (element) => element['widget-type'] == 'footer',
          )
          .toList();

      footerData = footerItems.isNotEmpty ? footerItems.first : null;

      dataList.sort((a, b) {
        final aOrder = a['order'] as int? ?? 0;
        final bOrder = b['order'] as int? ?? 0;
        return aOrder.compareTo(bOrder);
      });

      layoutData.clear();
      layoutData.addAll(dataList);
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
    debugPrint('layoutData: ${layoutData.toString()}');
    setState(() {
      isLoading = false;
    });

    return dataList;
  }

  Widget returnTheWidget(Map<String, dynamic> mapData) {
    final String widgetType = mapData['widget-type'] as String? ?? '';
    final int typeNumber = mapData['widget-number'] as int? ?? 0;
    Widget currentWidget = const Gap(10);

    switch (widgetType) {
      case DynamicWidgetTypes.BANNER:
        if (typeNumber == 1) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String redirection = mapData['ontap-route'] as String? ?? '';

          currentWidget = BannerType1(
            imageUrl: imageUrl,
            redirection: redirection,
          );
        } else if (typeNumber == 2) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String redirection = mapData['ontap-route'] as String? ?? '';

          currentWidget = BannerType2(
            imageUrl: imageUrl,
            redirection: redirection,
          );
        } else if (typeNumber == 3) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String redirection = mapData['ontap-route'] as String? ?? '';

          currentWidget = BannerType3(
            imageUrl: imageUrl,
            redirection: redirection,
          );
        }
        break;
      case DynamicWidgetTypes.CAROUSEL:
        if (typeNumber == 1) {
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = CarouselType1(children: children);
        } else if (typeNumber == 2) {
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = CarouselType2(children: children);
        }
        break;
      case DynamicWidgetTypes.RALEWAY:
        if (typeNumber == 1) {
          final String title = mapData['title'] as String? ?? '';
          final String? headerLogo = mapData['headerLogo'] as String?;
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = RalewayType1(
            heading: title,
            headerLogo: headerLogo,
            children: children,
          );
        } else if (typeNumber == 2) {
          final String title = mapData['title'] as String? ?? '';
          final String? headerLogo = mapData['headerLogo'] as String?;
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = RalewayType2(
            heading: title,
            headerLogo: headerLogo,
            children: children,
          );
        }
        break;
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Gap(20),
                    WelcomeType1(greeting: 'Good Morning', name: 'John Doe'),
                    const Gap(20),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ...layoutData.map((data) => returnTheWidget(data)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: PageFooter(footerData: footerData),
          )
        ],
      ),
    );
  }
}
