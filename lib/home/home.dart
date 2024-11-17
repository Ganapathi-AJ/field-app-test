import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fieldapp_functionality/arplugin/arplugin.dart';
import 'package:fieldapp_functionality/global/constants.dart';
import 'package:fieldapp_functionality/global/global_widgets.dart';
import 'package:fieldapp_functionality/global/widgets/custon_webview.dart';
import 'package:fieldapp_functionality/imageanaylisys_labled.dart';
import 'package:fieldapp_functionality/login/redirect.dart';
import 'package:fieldapp_functionality/plugins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../global/widgets/bottombar.dart';
import '../global/widgets/quicktools.dart';

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
  Widget? FooterWidget;
  final List<Map<String, dynamic>> layoutData = [];
  late final List<Widget> pages;
  final Map<String, int> routeToIndex = {'/home': 0};

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Map<String, dynamic> flags = {};

  late String clientName;
  fetchAllData() async {
    await fetchClientName();
    await fetchData();
    await fetchFlags();
  }

  Future<String?> fetchClientName() async {
    try {
      // Get the currently logged-in user's email
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user is currently logged in.");
      }

      final userEmail = currentUser.email;
      if (userEmail == null) {
        throw Exception("Logged-in user does not have an email.");
      }

      // Access the Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Query the "users" collection for a document where the "users" array contains the current user's email
      final querySnapshot = await firestore.collection('users').get();

      for (var doc in querySnapshot.docs) {
        final userList = doc.data()['users'] as List<dynamic>?;

        if (userList != null) {
          for (var user in userList) {
            if (user is Map<String, dynamic> && user['email'] == userEmail) {
              clientName = doc.id;
              return doc.id; // Return the client name (document ID)
            }
          }
        }
      }

      // If no matching client is found

      return null;
    } catch (e) {
      print("Error fetching client name: $e");
      return null;
    }
  }

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
          .doc(clientName)
          .get();

      layoutTypeNumber = clientDoc.data()?['layout-type'] ?? 1;

      final collectionRef = FirebaseFirestore.instance
          .collection('homepage-layout')
          .doc(clientName)
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

    buildFooterWidget(footerData ?? {});
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
        } else if (typeNumber == 4) {
          final String title = mapData['title'] as String? ?? '';
          final String imageUrl = mapData['imageUrl'] as String? ?? '';
          final String route = mapData['ontap-route'] as String? ?? '';
          final String url = mapData['url'] as String? ?? '';

          currentWidget = BannerType4(
              title: title,
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
      case DynamicWidgetTypes.QUICKTOOLS:
        currentWidget = QuickTools();
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

  buildFooterWidget(Map<String, dynamic> mapData) {
    final int widgetNum = mapData['widget-number'] as int? ?? 0;
    if (widgetNum == 1) {
      FooterWidget = CustomBottomNavBar(
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
      );
    } else if (widgetNum == 2) {
      FooterWidget = BottomBar2(
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
      );
    } else {
      FooterWidget = BottomBar2(
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
      );
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Do you want to logout?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Redirect();
                                          }));
                                        },
                                        child: Text('Confirm'))
                                  ],
                                );
                              });
                        },
                        child: FieldImage(
                          'assets/Image-60.png',
                          width: 0.03.sh,
                          height: 0.03.sh,
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildHeaderWidget(),
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
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FooterWidget,
          )
        ],
      ),
    );
  }
}

// custom_bottom_nav_bar.dart
