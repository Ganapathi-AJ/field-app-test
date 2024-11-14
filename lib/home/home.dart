import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldapp_functionality/arplugin/arplugin.dart';
import 'package:fieldapp_functionality/global/constants.dart';
import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:fieldapp_functionality/global/widgets/custon_webview.dart';
import 'package:fieldapp_functionality/imageanaylisys_labled.dart';
import 'package:fieldapp_functionality/plugins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

// home_screen.dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  int currentIndex = 0;
  int layoutTypeNumber = 1;
  Map<String, dynamic>? footerData;
  final List<Map<String, dynamic>> layoutData = [];
  late final List<Widget> pages;
  final Map<String, int> routeToIndex = {'/home': 0};

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchFlags();
  }

  Map<String, dynamic> flags = {};

  Future<void> fetchFlags() async {
    final DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore
        .instance
        .collection('modules')
        .doc('flags')
        .withConverter<Map<String, dynamic>>(
          fromFirestore: (snapshot, _) => snapshot.data() ?? {},
          toFirestore: (data, _) => data,
        );

    final DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await docRef.get();

    flags = querySnapshot.data() ?? {};
    print(flags);
  }

  bool isDisabled(String route) {
    bool isDisabled = false;
    final routeToModuleTable = {
      '/invoice': 'invoice',
      '/ar-module': 'ar-module',
      '/qr': 'qr',
      '/image': 'image-analysis',
      '/survey': 'survey',
      '/sales': 'sales',
      '/home': 'home',
      '/inventory': 'inventory',
      '/knowledge': 'knowledge',
      'image-labled': 'image-analysis-labled'
    };
    // print('flag: ' + flags[routeToModuleTable[route]]);

    if (flags[routeToModuleTable[route]] == false) {
      isDisabled = true;
    }
    return isDisabled;
  }

  Future<void> fetchData() async {
    try {
      final clientDoc = await FirebaseFirestore.instance
          .collection('homepage-layout')
          .doc('client11')
          .get();

      layoutTypeNumber = clientDoc.data()?['layout-type'] ?? 1;

      final collectionRef = FirebaseFirestore.instance
          .collection('homepage-layout')
          .doc('client11')
          .collection('children');

      final QuerySnapshot querySnapshot = await collectionRef.get();

      final dataList = querySnapshot.docs
          .map((doc) => doc.data())
          .whereType<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .toList();

      final footerItems = dataList
          .where((element) => element['widget-type'] == 'footer')
          .toList();

      footerData = footerItems.isNotEmpty ? footerItems.first : null;

      dataList.sort((a, b) =>
          (a['order'] as int? ?? 0).compareTo(b['order'] as int? ?? 0));

      layoutData
        ..clear()
        ..addAll(dataList);

      initializePages();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  void pluginNotActivated(BuildContext ctx) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Plugin is Not Activated")));
  }

  List<dynamic> footerChildren = [];
  void initializePages() {
    pages = [buildHomePage()];

    footerChildren = footerData?['children'] as List<dynamic>? ?? [];

    for (var i = 0; i < footerChildren.length; i++) {
      final String route = footerChildren[i]['ontap-route'] as String? ?? '';
      routeToIndex[route] = i + 1;
      pages.add(getPageForRoute(route));
    }
  }

  Widget returnTheWidget(Map<String, dynamic> mapData) {
    final String widgetType = mapData['widget-type'] as String? ?? '';
    final int typeNumber = mapData['widget-number'] as int? ?? 0;
    Widget currentWidget = const Gap(10);

    switch (widgetType) {
      case DynamicWidgetTypes.BANNER:
        if (typeNumber == 1) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String route = mapData['ontap-route'] as String? ?? '';

          currentWidget = BannerType1(
              imageUrl: imageUrl,
              onTap: () {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(mapData['url']);
                  }));
                  return;
                }
                if (flags.containsKey('')) if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 2) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String route = mapData['ontap-route'] as String? ?? '';
          final String url = mapData['url'] as String? ?? '';

          currentWidget = BannerType2(
              imageUrl: imageUrl,
              onTap: () {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 3) {
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String route = mapData['ontap-route'] as String? ?? '';
          final String url = mapData['url'] as String? ?? '';

          currentWidget = BannerType3(
              imageUrl: imageUrl,
              onTap: () {
                final index = routeToIndex[route];

                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }

                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        }
        break;
      case DynamicWidgetTypes.CAROUSEL:
        if (typeNumber == 1) {
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = CarouselType1(
              children: children,
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 2) {
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = CarouselType2(
              children: children,
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 3) {
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = CarouselType3(
              children: children,
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
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
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
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
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 3) {
          final String title = mapData['title'] as String? ?? '';
          final String? headerLogo = mapData['headerLogo'] as String?;
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = RalewayType3(
              heading: title,
              headerLogo: headerLogo,
              children: children,
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        } else if (typeNumber == 4) {
          final String title = mapData['title'] as String? ?? '';
          final String? headerLogo = mapData['headerLogo'] as String?;
          final List<Map<String, dynamic>> children =
              (mapData['children'] as List<dynamic>?)
                      ?.map((e) => e as Map<String, dynamic>)
                      .toList() ??
                  [];

          currentWidget = RalewayType4(
              heading: title,
              headerLogo: headerLogo,
              children: children,
              onTap: (route, url) {
                final index = routeToIndex[route];
                if (isDisabled(route)) {
                  pluginNotActivated(context);
                  return;
                }
                if (route == '/webview') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomWebview(url);
                  }));
                  return;
                }
                if (index != null) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              });
        }
        break;
    }

    return Padding(
        padding: EdgeInsets.only(bottom: 0.015.sh), child: currentWidget);
  }

  Widget buildHeaderWidget() {
    if (layoutTypeNumber == 1) {
      return WelcomeType1(greeting: 'Good Morning', name: 'John Doe');
    } else if (layoutTypeNumber == 2) {
      return SizedBox(height: 0.05.sh);
    } else {
      return const SizedBox();
    }
  }

  Widget getPageForRoute(String route) {
    switch (route) {
      case '/invoice':
        return InvoiceScanningScreen();
      case '/ar-module':
        return const UnityDemoScreen();
      case '/qr':
        return QRBarcodeScannerScreen();
      case '/image':
        return ImageAnalysisScreen();
      case '/image-labled':
        return ImageAnalysisLabledScreen();
      case '/survey':
        return const SurveyForm();
      case '/sales':
        return const SalesDashboard();
      case '/home':
        return const HomeScreen();
      case '/inventory':
        return const InventoryManagementScreen();
      case '/knowledge':
        return const KnowledgeHub();
      default:
        return const SizedBox();
    }
  }

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isLoading = true;
      });
      fetchData();
      fetchFlags();
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  Widget buildHomePage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: FieldImage(
            'assets/corner-leaf.png',
            width: 0.5 * MediaQuery.of(context).size.width,
            height: 0.3 * MediaQuery.of(context).size.height,
          ),
        ),
        RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Symbols.notifications,
                        size: 0.03.sh,
                      ),
                      const SizedBox(width: 10),
                      FieldImage(
                        'assets/Image-60.png',
                        width: 0.03.sh,
                        height: 0.03.sh,
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //   buildHeaderWidget(),
                  ...layoutData.map((data) => returnTheWidget(data)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        footerData: footerData,
        onIndexChanged: (index) {
          if (index == 0) {
            setState(() {
              currentIndex = index;
            });
          } else {
            final route = footerChildren[index - 1]['ontap-route'];
            if (isDisabled(route)) {
              pluginNotActivated(context);
              return;
            }
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}

// custom_bottom_nav_bar.dart
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Map<String, dynamic>? footerData;
  final Function(int) onIndexChanged;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.footerData,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Container(
      height: sh * 0.11,
      padding: EdgeInsets.symmetric(horizontal: 10.67.w, vertical: 4.17.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.99.r),
            topRight: Radius.circular(12.99.r),
          ),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: 5.98.r,
            offset: const Offset(0, -1.24),
            spreadRadius: 0,
          )
        ],
      ),
      width: sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Symbols.home_rounded,
            label: 'Home',
            isSystemIcon: true,
          ),
          ..._buildDynamicNavItems(context),
        ],
      ),
    );
  }

  List<Widget> _buildDynamicNavItems(BuildContext context) {
    final List<dynamic> children = footerData?['children'] ?? [];
    final sh = MediaQuery.of(context).size.height;

    return List.generate(
      children.length,
      (i) => _buildNavItem(
        context,
        index: i + 1,
        icon: children[i]['icon'] ?? '',
        label: children[i]['title'] ?? '',
        isSystemIcon: false,
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required dynamic icon,
    required String label,
    required bool isSystemIcon,
  }) {
    final sh = MediaQuery.of(context).size.height;

    return ScalingButton(
      onTap: () => onIndexChanged(index),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                bottom: -sh * 0.07 / 3,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: sh * 0.06,
                  width: sh * 0.06,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                width: sh * 0.07,
                height: sh * 0.05,
                child: Align(
                  alignment: const Alignment(0, 0.9),
                  child: isSystemIcon
                      ? Icon(
                          icon,
                          size: sh * 0.03,
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                        )
                      : FieldImage(
                          icon,
                          height: sh * 0.03,
                          width: sh * 0.03,
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                        ),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 5.sp,
              color: currentIndex == index ? Colors.blue : Colors.grey,
              fontWeight:
                  currentIndex == index ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
