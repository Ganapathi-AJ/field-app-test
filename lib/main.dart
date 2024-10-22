import 'package:fieldapp_functionality/FileDownloader.dart';
import 'package:flutter/material.dart';
import 'random_image.dart' deferred as random_image;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _loadRandomImage() async {
    await random_image.loadLibrary();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => random_image.RandomImage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
          child: const FileDownloaderWidget(
              fileUrl:
                  "https://firebasestorage.googleapis.com/v0/b/field-app-3115d.appspot.com/o/filer.dart?alt=media&token=2b1e5511-f7d6-4f55-b92e-a88efb82aa72")),
    );
  }
}
