import 'package:file_sharing/app/modules/finding/device_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/finding_controller.dart';

class FindingView extends GetView<FindingController> {
  const FindingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finding'), centerTitle: true),
      body: Column(
        children: [
          const Spacer(),

          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withValues(alpha: .08),
            ),
            child: const Icon(
              Icons.wifi_tethering,
              size: 100,
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Looking for nearby devices...",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Make sure the receiver is ready",
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nearby Devices",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                DeviceTile.show("Galaxy S24", Icons.phone_android),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
