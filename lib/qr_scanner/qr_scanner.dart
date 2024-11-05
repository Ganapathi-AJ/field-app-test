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
    return Scaffold(
      appBar: AppBar(title: Text('QR & Barcode Scanner')),
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
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
