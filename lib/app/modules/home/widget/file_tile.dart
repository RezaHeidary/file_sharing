import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileTile {
  FileTile._();
  static final _theme = Get.theme;
  static Widget show({
    required IconData icon,
    required Color color,
    required String fileName,
    required String device,
    required String size,
    required void Function()? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$size • $device",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.more_vert, color: _theme.iconTheme.color),
          ),
        ],
      ),
    );
  }
}
