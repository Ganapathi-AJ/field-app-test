import 'package:fieldapp_functionality/sales/sales.dart';
import 'package:fieldapp_functionality/attendance/attendance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:archive/archive_io.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dynamic Plugin Loader',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Plugin Loader'),
      ),
      body: plugins.isNotEmpty
          ? ListView(
              children: plugins.keys.map((pluginName) {
                return ListTile(
                  title: Text(pluginName),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => plugins[pluginName]!),
                    );
                  },
                );
              }).toList(),
            )
          : const Center(
              child: const Text('No plugins available'),
            ),
    );
  }
}

Map<String, Widget> plugins = {'Sales': Sales(),};

