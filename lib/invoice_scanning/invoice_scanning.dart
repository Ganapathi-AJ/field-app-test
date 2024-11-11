import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';

const primaryColorInvoice = Color(0xff369EFF);

class FoldedEdgeContainer extends StatelessWidget {
  final Widget child;

  const FoldedEdgeContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FoldedEdgePainter(),
      child: child,
    );
  }
}

class FoldedEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Path mainPath = Path();
    mainPath.moveTo(0, 0);
    mainPath.lineTo(size.width - 40, 0);
    mainPath.lineTo(size.width, 40);
    mainPath.lineTo(size.width, size.height);
    mainPath.lineTo(0, size.height);
    mainPath.close();

    canvas.drawPath(mainPath, paint);

    final borderPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(mainPath, borderPaint);

    final Path foldedPath = Path();
    foldedPath.moveTo(size.width - 40, 0);
    foldedPath.lineTo(size.width, 40);
    foldedPath.lineTo(size.width - 40, 40);
    foldedPath.close();

    final Paint foldedPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    canvas.drawPath(foldedPath, foldedPaint);

    canvas.drawPath(foldedPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class InvoiceScanningScreen extends StatefulWidget {
  InvoiceScanningScreen({super.key});

  @override
  State<InvoiceScanningScreen> createState() => _InvoiceScanningScreenState();
}

class _InvoiceScanningScreenState extends State<InvoiceScanningScreen> {
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

  List<File> _scannedImages = [];

  Future<void> _scanDocument() async {
    try {
      final scannedDocument = await CunningDocumentScanner.getPictures();
      if (scannedDocument!.isNotEmpty) {
        setState(() {
          _scannedImages.add(File(scannedDocument[0]));
        });
      }
    } catch (e) {
      print('Error scanning document: $e');
    }
  }

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
        title: Text('Invoice Scanning',
            style: TextStyle(
              fontSize: 0.04 * sw,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 247, 250),
      floatingActionButton: SizedBox(
        width: 100,
        height: 42,
        child: FloatingActionButton.extended(
          onPressed: () {
            _scanDocument();
          },
          extendedPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          label: const SizedBox(
            child: Text(
              'Scan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'GoogleSans',
              ),
            ),
          ),
          icon: Icon(
            Icons.camera_alt,
            size: 18,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xFF4285F4),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
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
                      SizedBox(),
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
                      ),
                      SizedBox(),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                },
                if (_scannedImages.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 2.7,
                      ),
                      itemCount: _scannedImages.length,
                      itemBuilder: (context, index) {
                        return FoldedEdgeContainer(
                          child: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#Invoice",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Bill No: #abcdefghiaak1053",
                                  style: TextStyle(
                                    fontSize: 8.5,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: Image.file(
                                    _scannedImages[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 12),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "170.10",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Created",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Nov 1, 2010",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Method",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        "Scanned",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
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
                              color: primaryColorInvoice),
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
                          onTap: () {
                            // _scanDocument();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColorInvoice.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Symbols.camera_rounded,
                                      size: 20, color: primaryColorInvoice),
                                  Gap(10),
                                  Text(
                                    "Capture",
                                    style: TextStyle(
                                        color: primaryColorInvoice,
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
