import 'package:fieldapp_functionality/arplugin/arplugin.dart';
import 'package:fieldapp_functionality/imageanalysis/imageanalysis.dart';
import 'package:fieldapp_functionality/invoice_scanning/invoice_scanning.dart';
import 'package:fieldapp_functionality/qr_scanner/qr_scanner.dart';
import 'package:fieldapp_functionality/sales/sales.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SalesDashboard();
                  }));
                },
                child: Text("Sales Dashboard")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return InvoiceScanningScreen();
                  }));
                },
                child: Text("Invoice Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return QRBarcodeScannerScreen();
                  }));
                },
                child: Text("QR Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ImageAnalysisScreen();
                  }));
                },
                child: Text("Image Analysis")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WebViewPage(
                      url: "https://mywebar.com/p/Project_0_wrctjhqt9p",
                    );
                  }));
                },
                child: Text("Image Analysis")),
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

