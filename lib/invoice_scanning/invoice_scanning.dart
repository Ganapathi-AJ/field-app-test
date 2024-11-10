import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';

const primaryColor = Color(0xff369EFF);

class InvoiceScanningScreen extends StatelessWidget {
  InvoiceScanningScreen({super.key});

  final bool noInvoiceAvl = false;

  final invoce = {
    [
      {
        "id": 1,
        "billno": "#dd7shg-aga43-satge53",
        "amount": "₹ 500",
        "date": "12/12/2021",
        "method": "scan"
      },
      {
        "id": 2,
        "billno": "#dd7shg-aga43-satge53",
        "amount": "₹ 500",
        "date": "12/12/2021",
        "method": "added manually"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        title: const Text('Invoice Scanning'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (noInvoiceAvl) ...{
                Image.asset(
                  'assets/no_invoice_banner.png',
                  scale: 4.3,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CaptureInvoice()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromARGB(255, 54, 158, 255),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Symbols.document_scanner,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Scan Invoice',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              },
              if (!noInvoiceAvl) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(23, 26, 137, 255),
                            child: Icon(
                              Symbols.add,
                              color: Color.fromARGB(255, 54, 158, 255),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Add\nInvoice',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const RadialGradient(colors: [
                                Color.fromARGB(46, 54, 158, 255),
                                Color.fromARGB(37, 54, 158, 255),
                                Color.fromARGB(20, 54, 158, 255),
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '36',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Color.fromARGB(255, 54, 158, 255)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Saved\nInvoices",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saved Invoices",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "View all",
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 15, color: Colors.blue)
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class CaptureInvoice extends StatefulWidget {
  const CaptureInvoice({super.key});

  @override
  State<CaptureInvoice> createState() => _CaptureInvoiceState();
}

class _CaptureInvoiceState extends State<CaptureInvoice> {
  CameraController? _controller;
  TextEditingController userspokenController = TextEditingController();
  bool _isListening = false;
  String _text = '';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  Future<void> _captureImage() async {
    try {
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/${DateTime.now()}.png';
      await _controller!.takePicture().then((image) async =>
          File(imagePath).writeAsBytes(await image.readAsBytes()));
      setState(() {
        _imageFile = File(imagePath);
        _controller!.dispose();
        _controller = null;
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('invoices/${DateTime.now()}.png');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null && _imageFile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_controller != null) CameraPreview(_controller!),
            if (_imageFile != null)
              Column(
                children: [
                  const Gap(80),
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _imageFile!,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: userspokenController,
                          decoration: const InputDecoration(
                            hintText:
                                "Type or talk to add description for selected image",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _text = value;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Symbols.arrow_back_ios,
                              color: primaryColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          'Scan QR/Barcode',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        const SizedBox(),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(10),
                      if (_imageFile == null)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Symbols.camera_rounded,
                                      size: 20, color: primaryColor),
                                  Gap(10),
                                  Text(
                                    "Capture",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      const Gap(10),
                      const Text(
                        "Place the product in front of the camera",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
