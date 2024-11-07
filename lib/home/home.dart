import 'package:fieldapp_functionality/inventory_management/inventory_management.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fieldapp_functionality/global/widgets/welcome.dart' as wd;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ));
  }
}
