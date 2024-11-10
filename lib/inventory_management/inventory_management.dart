import 'package:fieldapp_functionality/data/inventory_data.dart';
import 'package:fieldapp_functionality/qr_scanner/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Symbols.arrow_back_ios,
                            size: 17,
                            color: const Color(0xff4285F4),
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff4285F4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("Inventory Management",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                    const SizedBox(),
                    const SizedBox()
                  ],
                ),
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 300,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 10,
                              blurRadius: 5)
                        ],
                        color: Colors.white),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'Due Today',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: inventoryData.length,
                  itemBuilder: (context, index) {
                    Map currentItem = inventoryData.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return QRBarcodeScannerScreen();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 5)
                            ],
                            color: Colors.white),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Symbols.abc),
                            ),
                            Gap(10),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentItem['title']),
                                    Text(
                                      currentItem['client'],
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Gap(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Symbols.location_on),
                                        Text(
                                          currentItem['location'],
                                        ),
                                      ],
                                    ),
                                    Gap(3),
                                    Row(
                                      children: [
                                        Icon(Symbols.watch_later_rounded),
                                        Text(
                                          currentItem['time'],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
