import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomImage extends StatefulWidget {
  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchRandomImage();
  }

  Future<void> _fetchRandomImage() async {
    final response = await http.get(Uri.parse(
        'https://images.unsplash.com/photo-1729433321272-9243b22c5f6e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = response.request?.url.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _imageUrl == null
        ? CircularProgressIndicator()
        : Image.network(_imageUrl!);
  }
}
