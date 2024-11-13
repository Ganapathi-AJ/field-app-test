import 'package:fieldapp_functionality/data/inventory_data.dart';
import 'package:fieldapp_functionality/qr_scanner/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        iconTheme: IconThemeData(
          color: const Color.fromRGBO(54, 158, 255, 1),
        ),
        title: Text('Job Management',
            style: TextStyle(
              fontSize: 0.04 * sw,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 247, 250),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: Container(
                      width: sw - 40,
                      height: sh / 10,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...inventoryHeaderData.map(
                            (currentItem) {
                              Color capusleColor = Colors.grey;
                              String status = 'Unknown';
                              if (currentItem['status'] ==
                                  InventoryStatus.COMPLETED) {
                                capusleColor = Colors.green;
                                status = 'Completed';
                              }
                              if (currentItem['status'] ==
                                  InventoryStatus.OVERDUE) {
                                capusleColor = Colors.red;
                                status = 'Overdue';
                              }
                              if (currentItem['status'] ==
                                  InventoryStatus.ONGOING) {
                                capusleColor = Colors.orange;
                                status = 'Ongoing';
                              }
                              if (currentItem['status'] ==
                                  InventoryStatus.TODO) {
                                capusleColor = Colors.blue;
                                status = 'To-do';
                              }

                              if (currentItem['status'] ==
                                  InventoryStatus.SHIPPED) {
                                capusleColor = Colors.purple;
                                status = 'Shipped';
                              }
                              return Container(
                                width: (sw - 100) / 5,
                                height: (sh / 10) - 10,
                                decoration: BoxDecoration(
                                  color: capusleColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentItem['number'].toString(),
                                        style: TextStyle(
                                            color: capusleColor, fontSize: 20),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          status.toString(),
                                          style: TextStyle(
                                              color: capusleColor,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    'Due Today',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Gap(10),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: inventoryData.length,
                itemBuilder: (context, index) {
                  Map currentItem = inventoryData.elementAt(index);
                  Color capusleColor = Colors.grey;
                  String status = 'Unknown';
                  if (currentItem['status'] == InventoryStatus.COMPLETED) {
                    capusleColor = Colors.green;
                    status = 'Completed';
                  }
                  if (currentItem['status'] == InventoryStatus.OVERDUE) {
                    capusleColor = Colors.red;
                    status = 'Overdue';
                  }
                  if (currentItem['status'] == InventoryStatus.ONGOING) {
                    capusleColor = Colors.orange;
                    status = 'Ongoing';
                  }
                  if (currentItem['status'] == InventoryStatus.TODO) {
                    capusleColor = Colors.blue;
                    status = 'To-do';
                  }

                  if (currentItem['status'] == InventoryStatus.SHIPPED) {
                    capusleColor = Colors.purple;
                    status = 'Shipped';
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return QRBarcodeScannerScreen();
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 5)
                          ],
                          color: Colors.white),
                      child: IntrinsicHeight(
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: capusleColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Icon(
                                      currentItem['icon'],
                                      color: capusleColor,
                                    ),
                                  ),
                                ),
                                Gap(10),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentItem['title'],
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          currentItem['client'],
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Gap(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Symbols.location_on,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              currentItem['location'],
                                            ),
                                          ],
                                        ),
                                        Gap(3),
                                        Row(
                                          children: [
                                            Icon(
                                              Symbols.watch_later_rounded,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 7),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: capusleColor),
                                    color: capusleColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: capusleColor,
                                        size: 9,
                                      ),
                                      SizedBox(
                                        width: 3.5,
                                      ),
                                      Text(
                                        status,
                                        style: TextStyle(
                                            color: capusleColor, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: Colors.black54,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
