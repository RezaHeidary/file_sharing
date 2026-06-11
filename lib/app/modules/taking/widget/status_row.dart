import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget statusRow(String title, String value) {
  final theme = Get.theme;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    ),
  );
}
