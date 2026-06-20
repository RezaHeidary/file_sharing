import 'dart:io';

import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class PhotosTab extends GetView<SendController> {
  const PhotosTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isPhotosLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.photos.isEmpty) {
      return EmptyDataWidget(
        onPressed: () {
          controller.loadPhotos();
        },
      );
    }

    // ۱. اضافه کردن شناسه اختصاصی 'photo_grid' به GetBuilder
    return GetBuilder<SendController>(
      id: UiIds.photoGrid, 
      builder: (SendController _) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.photos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, index) {
            final item = controller.photos[index];
            final asset = item.asset!;

            return GestureDetector(
              onTap: () {
                controller.toggleSelection(item);
                controller.update([UiIds.photoGrid]);
              },
              onLongPress: () async {
                final File? imageFile = await item.asset!.originFile;
                await OpenFilex.open(imageFile!.path);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AssetEntityImage(
                      asset,
                      isOriginal: false,
                      thumbnailSize: const ThumbnailSize(300, 300),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
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
