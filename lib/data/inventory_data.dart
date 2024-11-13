import 'package:flutter/material.dart';

List inventoryData = [
  {
    'title': 'Monitor Replacement Project',
    'client': 'For Susan Project',
    'location': 'From 15 mount street store',
    'time': '10 am to 1pmm',
    'status': InventoryStatus.COMPLETED,
    'icon': Icons.compass_calibration_outlined
  },
  {
    'title': 'MacBook Pro',
    'client': 'For Susan Project',
    'location': 'From 15 mount street store',
    'time': '10 am to 1pm',
    'status': InventoryStatus.SHIPPED,
    'icon': Icons.laptop_chromebook
  },
  {
    'title': 'Monitor Replacement Project',
    'client': 'For Geometric Centre Store',
    'location': 'From 15 mount street store',
    'time': '10 am to 1pm',
    'status': InventoryStatus.OVERDUE,
    'icon': Icons.phone_android
  },
  {
    'title': 'Monitor Replacement Project',
    'client': 'For Zoho Porject',
    'location': 'From 15 mount street store',
    'time': '10 am to 1pm',
    'status': InventoryStatus.TODO,
    'icon': Icons.qr_code_outlined
  },
  {
    'title': 'Monitor Replacement Project',
    'client': 'For Susan Project',
    'location': 'From 15 mount street store',
    'time': '10 am to 1pm',
    'status': InventoryStatus.ONGOING,
    'icon': Icons.earbuds
  },
];

class InventoryStatus {
  const InventoryStatus._();

  static const String COMPLETED = 'completed';
  static const String ONGOING = 'ongoing';
  static const String TODO = 'todo';
  static const String SHIPPED = 'shipped';
  static const String OVERDUE = 'overdue';
}

List inventoryHeaderData = [
  {'number': 26, 'status': InventoryStatus.OVERDUE},
  {'number': 24, 'status': InventoryStatus.ONGOING},
  {'number': 12, 'status': InventoryStatus.TODO},
  {'number': 22, 'status': InventoryStatus.SHIPPED},
  {'number': 420, 'status': InventoryStatus.COMPLETED}
];
