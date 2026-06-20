import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTab extends GetView<SendController> {
  const AppTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendController>(
      id:UiIds.appGrid,
      builder: (controller) {
        if (controller.isAppsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.apps.isEmpty) {
          return EmptyDataWidget(
            onPressed: () {
              controller.loadApps();
            },
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.apps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final item = controller.apps[index];

            return GestureDetector(
              onTap: () {
                controller.toggleSelection(item);
                controller.update([[UiIds.appGrid]]);
              },
          
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: item.iconBytes != null
                              ? Image.memory(
                                  item.iconBytes!,
                                  fit: BoxFit.contain,
                                )
                              : const Icon(
                                  Icons.apps,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (controller.isSelected(item))
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
