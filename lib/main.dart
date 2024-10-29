import 'package:fieldapp_functionality/attendance/attendance.dart';
import 'package:fieldapp_functionality/sales/sales.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:archive/archive_io.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Plugin Loader',
      home: PluginManager(),
    );
  }
}

class PluginManager extends StatefulWidget {
  @override
  _PluginManagerState createState() => _PluginManagerState();
}

class _PluginManagerState extends State<PluginManager> {
  bool isDownloading = false;
  String? downloadPath;

  @override
  void initState() {
    super.initState();
    FlutterDownloader.initialize();
  }

  Future<void> checkAndDownloadModule(String moduleName) async {
    // Check if module is enabled (Firestore Sync)
    bool isEnabled = await checkModuleEnabled(moduleName);

    if (isEnabled) {
      // Get Firebase Storage URL
      String downloadUrl = await getModuleDownloadURL(moduleName);

      // Download Module
      String? filePath = await downloadModule(downloadUrl, moduleName);

      if (filePath != null) {
        // Extract Module Files
        await extractModuleFiles(filePath);

        // Integrate module into the app (Deferred Loading)
        await integrateModule(moduleName);
      }
    }
  }

  Future<bool> checkModuleEnabled(String moduleName) async {
    DocumentSnapshot moduleDoc = await FirebaseFirestore.instance
        .collection('modules')
        .doc(moduleName)
        .get();
    return moduleDoc['enabled'] ?? false;
  }

  Future<String> getModuleDownloadURL(String moduleName) async {
    return await FirebaseStorage.instance
        .ref('$moduleName.zip')
        .getDownloadURL();
  }

  Future<String?> downloadModule(String url, String moduleName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$moduleName.zip';

    // Downloading the module using Flutter Downloader or HTTP
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir.path,
      fileName: '$moduleName.zip',
      showNotification: true,
      openFileFromNotification: true,
    );

    // Wait for download to complete
    // You can listen to FlutterDownloader's status in production apps
    return path; // Returning file path on completion
  }

  Future<void> extractModuleFiles(String filePath) async {
    // Read the zip file from the path
    final bytes = File(filePath).readAsBytesSync();

    // Decode the archive
    final archive = ZipDecoder().decodeBytes(bytes);

    // Extract the contents to the app's documents directory
    final dir = await getApplicationDocumentsDirectory();

    for (final file in archive) {
      final filename = '${dir.path}/${file.name}';
      if (file.isFile) {
        final data = file.content as List<int>;
        File(filename).writeAsBytesSync(data);
      } else {
        Directory(filename).create(recursive: true);
      }
    }

    // Optionally, you can delete the downloaded .zip file
    File(filePath).deleteSync();
  }

  Future<void> integrateModule(String moduleName) async {
    switch (moduleName) {
      case 'attendance':
        // Dynamically load attendance module (UI and logic)
        await loadAttendanceModule();
        break;
      case 'sales':
        await loadSalesModule();
        break;
      // Add more cases for other modules...
      default:
        print("Module not found");
    }
  }

  Future<void> loadAttendanceModule() async {
    // Use deferred loading to load the feature-specific code
    await Future.delayed(Duration(seconds: 1)); // Simulate deferred loading
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AttendanceModulePage()),
    );
  }

  Future<void> loadSalesModule() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate deferred loading
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalesModulePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDownloading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => checkAndDownloadModule('attendance'),
                child: Text('Enable Attendance Module'),
              ),
            ElevatedButton(
              onPressed: () => checkAndDownloadModule('sales'),
              child: Text('Enable Sales Module'),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceModulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Module'),
      ),
      body: Center(
        child: Text('Attendance Module Loaded!'),
      ),
    );
  }
}

class SalesModulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Module'),
      ),
      body: Center(
        child: Text('Sales Module Loaded!'),
      ),
    );
  }
}
