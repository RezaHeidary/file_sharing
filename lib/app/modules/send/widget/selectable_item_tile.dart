import 'package:file_sharing/app/data/model/send_item_model.dart';
import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableItemTile extends GetView<SendController> {
  final ShareItem item;
  final IconData icon;

  const SelectableItemTile({super.key, required this.item, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.isSelected(item);

      return ListTile(
        leading: Icon(icon),

        title: Text(item.name),

        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.transparent,
            border: Border.all(color: selected ? Colors.blue : Colors.grey),
            shape: BoxShape.circle,
          ),
          child: selected
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),

        onTap: () {
          controller.toggleSelection(item);
        },
      );
    });
  }
}
