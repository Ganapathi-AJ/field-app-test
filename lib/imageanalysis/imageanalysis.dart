import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class ImageAnalysisScreen extends StatefulWidget {
  @override
  _ImageAnalysisScreenState createState() => _ImageAnalysisScreenState();
}

class _ImageAnalysisScreenState extends State<ImageAnalysisScreen> {
  final TextEditingController _promptController = TextEditingController();
  String _analysisResult = "";
  bool _isLoading = false;

  Future<void> analyzeImage() async {
    setState(() {
      _isLoading = true;
      _analysisResult = ""; // Clear previous results
    });

    const imageUrl =
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg";
    final prompt = _promptController.text;

    try {
      final response = await http
          .post(
            Uri.parse(
                'https://image-analysis-vj3t6ewmoa-uc.a.run.app/analyze-image/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              "image_url": imageUrl,
              "prompt": prompt,
            }),
          )
          .timeout(const Duration(seconds: 60)); // Set a timeout duration here

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _analysisResult = data['analysis'];
        });
      } else {
        setState(() {
          _analysisResult =
              "Error: Unable to analyze the image. Server responded with status ${response.statusCode}.";
        });
      }
    } on SocketException {
      setState(() {
        _analysisResult =
            "Network error: Could not connect to the server. Please check your internet connection.";
      });
    } on TimeoutException {
      setState(() {
        _analysisResult = "Request timed out. Please try again later.";
      });
    } catch (e) {
      setState(() {
        _analysisResult = "An error occurred: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CameraScreen(),

      //  Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Container(
      //           height: 200,
      //           width: double.infinity,
      //           color: Colors.grey[300],
      //           child: const Center(
      //             child: Text(
      //               'Select an Image',
      //               style: TextStyle(fontSize: 18, color: Colors.black54),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         TextField(
      //           controller: _promptController,
      //           decoration: const InputDecoration(
      //             labelText: 'Enter your prompt',
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: _isLoading ? null : analyzeImage,
      //           child: _isLoading
      //               ? const CircularProgressIndicator(color: Colors.white)
      //               : const Text('Analyze Image'),
      //         ),
      //         const SizedBox(height: 20),
      //         _analysisResult.isNotEmpty
      //             ? const Text(
      //                 'Analysis Result:',
      //                 style: const TextStyle(
      //                     fontSize: 18, fontWeight: FontWeight.bold),
      //               )
      //             : Container(),
      //         const SizedBox(height: 10),
      //         Text(
      //           _analysisResult,
      //           style: const TextStyle(fontSize: 16),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  stt.SpeechToText _speech = stt.SpeechToText();
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
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (error) => print('onError: $error'),
    );
    print("Listening: $available");
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          print("Result: ${result.recognizedWords}");
          setState(() => _text = result.recognizedWords);
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        localeId: "en_US",
        onSoundLevelChange: (level) => print("Sound level: $level"),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
    if (_text.isNotEmpty && _imageFile != null) {
      _analyzeImage();
    }
  }

  Future<void> _analyzeImage() async {
    if (_imageFile == null) return;

    setState(() => _isListening = false);
    final imageUrl = await _uploadImageToFirebase(_imageFile!);

    print("Image URL: $imageUrl");
    print("Prompt: $_text");

    final response = await http.post(
      Uri.parse(
          'https://image-analysis-vj3t6ewmoa-uc.a.run.app/analyze-image/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "image_url": imageUrl,
        "prompt": _text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            analysisResult: data['analysis'],
          ),
        ),
      );
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CameraPreview(_controller!),
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
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          'Image Analysis',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.done_rounded,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultsScreen(
                                          analysisResult: "data['analysis']",
                                        )));
                          },
                        ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_imageFile == null)
                        IconButton(
                          icon: const Icon(Icons.camera,
                              size: 20, color: Colors.black),
                          onPressed: _captureImage,
                        ),
                      const Flexible(
                        child: Text("Place the product in front of the camera"),
                      ),
                      const SizedBox(width: 30),
                      if (_imageFile != null)
                        IconButton(
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                _isListening ? Icons.mic : Icons.mic_none,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          onPressed:
                              _isListening ? _stopListening : _startListening,
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

class ResultsScreen extends StatelessWidget {
  final String analysisResult;

  ResultsScreen({required this.analysisResult});

  final data = {
    "Memory and Storage": "12 GB RAM 24 GB",
    "Processor": "M3 Chip",
    "Dimensions and Weight": "152.8 mm x 72 mm x 8.5 mm ",
    "Operating System": "Launched with iOS 15",
    "Buttons and Ports": "USB Type-C 32",
    "Authentication": "Fingerpring and Face Unlock",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Image Analysis',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildResultComponent(
                  'Memory and Storage', data['Memory and Storage']!),
              const Gap(10),
              _buildResultComponent('Processor', data['Processor']!),
              const Gap(10),
              _buildResultComponent(
                  'Dimensions and Weight', data['Dimensions and Weight']!),
              const Gap(10),
              _buildResultComponent(
                  'Operating System', data['Operating System']!),
              const Gap(10),
              _buildResultComponent(
                  'Buttons and Ports', data['Buttons and Ports']!),
              const Gap(10),
              _buildResultComponent('Authentication', data['Authentication']!),
              const Gap(10),
              CarouselWithArrows(
                items: [_buildCarouselItem(), _buildCarouselItem()],
              )
            ],
          ),
        ),
      ),
    );
  }
}

const primaryColor = Color(0xFF4285F4);

Widget _buildResultComponent(String title, String value) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.memory, color: primaryColor),
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCarouselItem() {
  return Container(
    width: 330,
    height: 500,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Display",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Gap(10),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• 6.1-inch Liquid Retina HD display"),
                  Gap(5),
                  Text("• True Tone"),
                  Gap(5),
                  Text("• Wide color (P3)"),
                  Gap(5),
                  Text("• Haptic Touch"),
                  Gap(5),
                  Text("• 625 nits max brightness (typical)"),
                  Gap(5),
                  Text("• Fingerprint-resistant oleophobic coating"),
                  Gap(5),
                  Text(
                      "• Support for display of multiple languages and characters simultaneously"),
                  Gap(5),
                  Text("• 1400:1 contrast ratio (typical)"),
                  Gap(5),
                  Text("• 326 ppi"),
                  Gap(5),
                ],
              ),
            )
          ],
        )),
  );
}

class CarouselWithArrows extends StatefulWidget {
  final List<Widget> items;

  CarouselWithArrows({required this.items});

  @override
  _CarouselWithArrowsState createState() => _CarouselWithArrowsState();
}

class _CarouselWithArrowsState extends State<CarouselWithArrows> {
  int _currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.items,
              carouselController: carouselController,
              options: CarouselOptions(
                height: 400,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                    carouselController.animateToPage(index);
                  });
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    color: primaryColor,
                  ),
                  onPressed: _currentIndex > 0
                      ? () {
                          setState(() {
                            _currentIndex--;
                            carouselController.animateToPage(0);
                          });
                        }
                      : null,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_sharp,
                    color: primaryColor,
                  ),
                  onPressed: _currentIndex < widget.items.length - 1
                      ? () {
                          setState(() {
                            _currentIndex++;
                            carouselController.animateToPage(1);
                          });
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
