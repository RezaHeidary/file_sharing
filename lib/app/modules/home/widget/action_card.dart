import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _size = Get.size;

class ActionCard {
  ActionCard._();
  static Widget show({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _size.height * .30,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color.withValues(alpha: .08),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
