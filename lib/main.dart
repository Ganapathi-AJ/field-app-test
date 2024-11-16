import 'package:fieldapp_functionality/arplugin/arplugin.dart';
import 'package:fieldapp_functionality/firebase_options.dart';
import 'package:fieldapp_functionality/home/home.dart';
import 'package:fieldapp_functionality/imageanaylisys_labled.dart';
import 'package:fieldapp_functionality/login/redirect.dart';
import 'package:fieldapp_functionality/plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'videocall/videocall.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(166, 377),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            title: 'Dynamic Plugin Loader',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'Urbanist'),
            home: const Redirect(),
            routes: {
              '/invoice': (context) => InvoiceScanningScreen(),
              '/ar-module': (context) => const UnityDemoScreen(),
              '/qr': (context) => QRBarcodeScannerScreen(),
              '/image': (context) => ImageAnalysisScreen(),
              '/image-labled': (context) => ImageAnalysisLabledScreen(),
              '/survey': (context) => const SurveyForm(),
              '/sales': (context) => const SalesDashboard(),
              '/home': (context) => const HomeScreen(),
              '/inventory': (context) => const InventoryManagementScreen(),
              '/knowledge': (context) => const KnowledgeHub(),
            },
          );
        });
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          // HomeScreen(),

          Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SalesDashboard();
                  }));
                },
                child: const Text("Sales Dashboard")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UnityDemoScreen();
                  }));
                },
                child: const Text("Unity Demo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UnityDemoScreen();
                  }));
                },
                child: const Text("Unity Demo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return InvoiceScanningScreen();
                  }));
                },
                child: const Text("Invoice Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return QRBarcodeScannerScreen();
                  }));
                },
                child: const Text("QR Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ImageAnalysisScreen();
                  }));
                },
                child: const Text("Image Analysis")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SurveyForm();
                  }));
                },
                child: const Text("Survey Form")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                child: const Text("Home Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VideoCall();
                  }));
                },
                child: const Text("Video Call")),
          ],
        ),
      ),
      // plugins.isNotEmpty
      //     ? ListView(
      //         children: plugins.keys.map((pluginName) {
      //           return ListTile(
      //             title: Text(pluginName),
      //             trailing: const Icon(Symbols.arrow_forward),
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => plugins[pluginName]!),
      //               );
      //             },
      //           );
      //         }).toList(),
      //       )
      //     : const Center(
      //         child: const Text('No plugins available'),
      //       ),
    );
  }
}
