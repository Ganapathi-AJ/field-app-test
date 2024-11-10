import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:material_symbols_icons/symbols.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

final primaryColor = const Color(0xff4285F4);

class ImageAnalysisScreen extends StatefulWidget {
  @override
  _ImageAnalysisScreenState createState() => _ImageAnalysisScreenState();
}

class _ImageAnalysisScreenState extends State<ImageAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sw * 0.2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Symbols.arrow_back_ios,
                              size: 0.03 * sw,
                              color: primaryColor,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 0.03 * sw,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("Image Analysis",
                        style: TextStyle(
                          fontSize: 0.03 * sw,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: 0.2 * sw,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 0.6 * sw,
                      child: Image.asset("assets/img-analysis.png")),
                  const Gap(20),
                  Text(
                    "Use camera to click the image of the\nproduct",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.03 * sw,
                      color: Color(0xff45484F),
                    ),
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 18),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Open Camera",
                              style: TextStyle(
                                  fontSize: 0.027 * sw,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Gap(10),
                            Icon(
                              Symbols.camera_alt,
                              color: Colors.white,
                              size: 0.04 * sw,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox()
            ],
          ),
        ));
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  TextEditingController userspokenController = TextEditingController();
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
        _controller!.dispose();
        _controller = null;
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
      if (await _speech.hasPermission) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            print("Result: ${result.recognizedWords}");
            setState(() {
              _text = result.recognizedWords;
              userspokenController.text = _text;
            });
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 5),
          partialResults: true,
          localeId: "en_US",
          onSoundLevelChange: (level) => print("Sound level: $level"),
        );
      } else {
        bool permissionGranted = await _speech.initialize();
        if (permissionGranted) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (result) {
              print("Result: ${result.recognizedWords}");
              setState(() {
                _text = result.recognizedWords;
                userspokenController.text = _text;
              });
            },
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 5),
            partialResults: true,
            localeId: "en_US",
            onSoundLevelChange: (level) => print("Sound level: $level"),
          );
        } else {
          print("Microphone permission not granted");
        }
      }
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
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ResultsScreen(
      //       analysisResult: data['analysis'],
      //     ),
      //   ),
      // );
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null && _imageFile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FA),
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
                          icon:
                              Icon(Symbols.arrow_back_ios, color: primaryColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Image Analysis',
                          style: TextStyle(fontSize: 18, color: primaryColor),
                        ),
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
                          onTap: _captureImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Symbols.camera_rounded,
                                      size: 20, color: primaryColor),
                                  const Gap(10),
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
                      if (_imageFile != null)
                        GestureDetector(
                            onTap:
                                _isListening ? _stopListening : _startListening,
                            child: !_isListening
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60.0, vertical: 14),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Symbols.mic,
                                              size: 20, color: primaryColor),
                                          const Gap(10),
                                          Text(
                                            "Speak",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 100.0, vertical: 14),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "• • • •",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResultScreen(
                                                        img: _imageFile,
                                                        txt: _text,
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                primaryColor.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(13.0),
                                                child: Icon(
                                                  Symbols.arrow_forward,
                                                  size: 17,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                      const Gap(10),
                      const Text(
                        "Place the product in front of the camera",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      // if (_imageFile != null && _text.isNotEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       _text,
                      //       style: const TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ),
                      // if (_imageFile != null)
                      //   IconButton(
                      //     icon: const Icon(Symbols.arrow_forward_ios,
                      //         color: Colors.blue),
                      //     onPressed: () {
                      //       // Navigator.push(
                      //       //     context,
                      //       //     MaterialPageRoute(
                      //       //         builder: (context) => ResultsScreen(
                      //       //               analysisResult: "data['analysis']",
                      //       //             )));
                      //     },
                      //   ),
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

class ResultScreen extends StatefulWidget {
  File? img;
  String? txt;
  ResultScreen({super.key, required this.img, required this.txt});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? analysisResult;
  bool isLoading = true;

  Future<void> analyzeImage(File img) async {
    final url = Uri.parse(
        "https://image-analysis-vj3t6ewmoa-uc.a.run.app/analyze-image");

    final request = http.MultipartRequest("POST", url)
      ..fields["prompt"] =
          "Analyze this image and provide a summary in bullet points."
      ..fields["response_format[type]"] = "html"
      ..files.add(http.MultipartFile(
        "image",
        img.readAsBytes().asStream(),
        img.lengthSync(),
        filename: img.path.split("/").last,
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print("Image Analysis Result:");
      print(responseBody);
      final data = json.decode(responseBody);
      setState(() {
        analysisResult = data["analysis"];
        isLoading = false;
      });
    } else {
      print("Error: ${response.statusCode}");
      final error = await response.stream.bytesToString();
      print("Error details: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    analyzeImage(widget.img!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6F7FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Symbols.arrow_back_ios, color: primaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Image Analysis',
            style: TextStyle(fontSize: 18, color: primaryColor),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 19.0, vertical: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Row(
              //           children: [
              //             Icon(
              //               Symbols.arrow_back_ios,
              //               size: 17,
              //               color: primaryColor,
              //             ),
              //             Text(
              //               'Back',
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 color: primaryColor,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Text("Image Analysis",
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //             color: primaryColor,
              //           )),
              //       const SizedBox(),
              //       const SizedBox()
              //     ],
              //   ),
              // ),
              // const Gap(40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  widget.img!,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              widget.txt!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Symbols.auto_awesome,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                                padding: isLoading
                                    ? const EdgeInsets.all(18.0)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 17),
                                child: isLoading
                                    ? Column(
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 300,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 300,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 300,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 300,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 300,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                        ],
                                      )
                                    : HtmlWidget(removeFirstAndLastLine(
                                        analysisResult ?? ""))),
                            // : Text(analysisResult ?? "")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Icon(
            Symbols.camera_alt,
            color: Colors.white,
          ),
        ));
  }

  String removeFirstAndLastLine(String input) {
    List<String> lines = input.split('\n');
    if (lines.length <= 2) {
      return ''; // If there are 2 or fewer lines, return an empty string
    }
    return lines.sublist(1, lines.length - 1).join('\n');
  }
}
