import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
          .timeout(Duration(seconds: 60)); // Set a timeout duration here

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'Select an Image',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _promptController,
                decoration: const InputDecoration(
                  labelText: 'Enter your prompt',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : analyzeImage,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Analyze Image'),
              ),
              const SizedBox(height: 20),
              _analysisResult.isNotEmpty
                  ? const Text(
                      'Analysis Result:',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Text(
                _analysisResult,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
