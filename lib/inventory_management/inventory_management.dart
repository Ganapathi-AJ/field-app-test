import 'package:fieldapp_functionality/data/invent_managment.dart';
import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: inventoryData.length,
          itemBuilder: (context, index) {
            Map currentItem = inventoryData.elementAt(index);
            return ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.abc),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentItem['title']),
                  Text(
                    currentItem['client'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(
                        currentItem['location'],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      Text(
                        currentItem['time'],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
