import 'package:fieldapp_functionality/firebase_options.dart';
import 'package:fieldapp_functionality/home/home.dart';
import 'package:fieldapp_functionality/imageanalysis/imageanalysis.dart';
import 'package:fieldapp_functionality/invoice_scanning/invoice_scanning.dart';
import 'package:fieldapp_functionality/qr_scanner/qr_scanner.dart';
import 'package:fieldapp_functionality/sales/sales.dart';

import 'package:fieldapp_functionality/surveyform/surveyform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return const MaterialApp(
      title: 'Dynamic Plugin Loader',
      home: Home(),
    );
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

          //  HomeScreen()

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
                    return const InvoiceScanningScreen();
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
          ],
        ),
      ),
      // plugins.isNotEmpty
      //     ? ListView(
      //         children: plugins.keys.map((pluginName) {
      //           return ListTile(
      //             title: Text(pluginName),
      //             trailing: const Icon(Icons.arrow_forward),
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


// Map<String, Widget> plugins = {'Sales': Sales(),};

