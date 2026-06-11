import 'package:file_sharing/app/core/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferItem extends StatelessWidget {
  final String fileName;
  final double progress;
  final IconData icon;

  const TransferItem({
    super.key,
    required this.fileName,
    required this.progress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: theme.iconTheme.color),

              const SizedBox(width: AppDimens.small),

              Expanded(
                child: Text(
                  fileName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "${(progress * 100).toInt()}%",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.medium),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: progress, minHeight: 8),
          ),
        ],
      ),
    );
  }
}
