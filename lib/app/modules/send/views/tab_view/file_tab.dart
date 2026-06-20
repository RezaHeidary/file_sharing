import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class FilesTab extends GetView<SendController> {
  const FilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isFilesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.files.isEmpty) {
      return  EmptyDataWidget(
            onPressed: () {
              controller.loadFiles();
            },
          );
    }

    return GetBuilder<SendController>(
      id: UiIds.fileGrid,
      builder: (SendController _) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
      
          itemCount: controller.files.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, index) {
            final item = controller.files[index];

            return GestureDetector(
              onTap: () {
                controller.toggleSelection(item);
                controller.update([UiIds.fileGrid]); 
              },
              onLongPress: () async {
                await OpenFilex.open(item.path);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
          
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.insert_drive_file,
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
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
