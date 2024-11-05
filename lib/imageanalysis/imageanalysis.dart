import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Image Analysis'),
      ),
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

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  List<CameraDescription> cameras = [];

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (result) {
        print(result);
        setState(() => _text = result.recognizedWords);
      });
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
    if (_text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            text: _text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.camera,
                    //       size: 20, color: Colors.black),
                    //   onPressed: () {
                    //     // Implement image capture if needed
                    //   },
                    // ),
                    Flexible(
                        child:
                            Text("Place the product in front of the camera")),
                    const SizedBox(width: 30),
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
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final String text;

  ResultsScreen({required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'User Prompt: $text',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}