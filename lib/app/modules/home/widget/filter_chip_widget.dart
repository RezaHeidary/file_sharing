import 'package:file_sharing/app/core/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterChipWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;

  const FilterChipWidget({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected
            ? Colors.blue.withValues(alpha: .1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: selected ? Colors.blue : Colors.grey),
          const SizedBox(width: AppDimens.small),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: selected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
