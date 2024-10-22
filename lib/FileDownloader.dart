import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FileDownloaderWidget extends StatefulWidget {
  final String fileUrl;

  const FileDownloaderWidget({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<FileDownloaderWidget> createState() => _FileDownloaderWidgetState();
}

class _FileDownloaderWidgetState extends State<FileDownloaderWidget> {
  String? downloadedFilePath;
  bool isLoading = false;
  String? errorMessage;
  Widget? dynamicWidget;

  Future<void> downloadAndProcessFile() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Download file using cache manager
      final file = await DefaultCacheManager().getSingleFile(widget.fileUrl);

      // Read the content
      final content = await file.readAsString();

      // Save file to app documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'random_image.dart';
      final savedFile = File('${appDir.path}/$fileName');
      await savedFile.writeAsString(content);

      setState(() {
        downloadedFilePath = savedFile.path;
        isLoading = false;
      });

      // Here you would typically use some method to evaluate and render the downloaded Dart code
      // Note: Directly executing downloaded Dart code can be unsafe
      // You should implement proper security measures and code validation
      await loadAndRenderUI(content);
    } catch (e) {
      setState(() {
        errorMessage = 'Error downloading file: $e';
        isLoading = false;
      });
    }
  }

  Future<void> loadAndRenderUI(String dartCode) async {
    // IMPORTANT: This is a simplified example
    // In a real application, you should:
    // 1. Validate the downloaded code
    // 2. Implement proper security measures
    // 3. Use a proper compilation/interpretation method

    // For demonstration, we'll create a simple widget
    setState(() {
      dynamicWidget = Container(
        padding: const EdgeInsets.all(16),
        color: Colors.green.shade100,
        child: const Column(
          children: [
            Text('Downloaded Widget Placeholder'),
            Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : downloadAndProcessFile,
          child: Text(isLoading ? 'Downloading...' : 'Download and Run File'),
        ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        if (downloadedFilePath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('File saved at: $downloadedFilePath'),
          ),
        if (dynamicWidget != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: dynamicWidget!,
          ),
      ],
    );
  }
}
