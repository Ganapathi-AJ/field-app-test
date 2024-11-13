import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRBarcodeScannerScreen extends StatefulWidget {
  @override
  _QRBarcodeScannerScreenState createState() => _QRBarcodeScannerScreenState();
}

class _QRBarcodeScannerScreenState extends State<QRBarcodeScannerScreen> {
  String? scanResult;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        iconTheme: IconThemeData(
          color: const Color.fromRGBO(54, 158, 255, 1),
        ),
        title: Text('Inventory Management',
            style: TextStyle(
              fontSize: 0.04 * sw,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final String? value =
                    barcodes.isNotEmpty ? barcodes.first.rawValue : null;
                setState(() {
                  scanResult = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scanResult != null
                    ? 'Result: $scanResult'
                    : 'Scan a QR code or Barcode',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
