import 'dart:io';
import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class VideosTab extends GetView<SendController> {
  const VideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isVideosLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.videos.isEmpty) {
      return EmptyDataWidget(
        onPressed: () {
          controller.loadVideos();
        },
      );
    }

    return GetBuilder<SendController>(
      id: UiIds.videoGrid,
      builder: (_) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.videos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final item = controller.videos[index];
            final videoPath = item.path;

            final thumbPath = controller.videoThumbnails[videoPath];

            if (thumbPath == null) {
              controller.loadVideoThumbnail(videoPath);
            }

            return GestureDetector(
              onTap: () {
                controller.toggleSelection(item);
                controller.update([UiIds.videoGrid]);
              },
              onLongPress: () async {
                await OpenFilex.open(item.path);
              },

              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: thumbPath != null
                        ? Image.file(
                            File(thumbPath),
                            fit: BoxFit.cover,
                            cacheWidth: 200,
                          )
                        : Container(
                            color: Colors.grey.shade900,
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                  ),

                  // ۲. دکمه پلی وسط ویدیو
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  // ۳. بخش تیک انتخاب
                  if (controller.isSelected(item))
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
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
