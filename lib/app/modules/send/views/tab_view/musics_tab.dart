import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class MusicTab extends GetView<SendController> {
  const MusicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendController>(
      id: UiIds.musicGrid, 
      builder: (controller) {
        if (controller.isMusicsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.musics.isEmpty) {
          return EmptyDataWidget(
            onPressed: () {
              controller.loadMusic();
            },
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.musics.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final item = controller.musics[index];

            return GestureDetector(
              onTap: () {
                controller.toggleSelection(item);
            
                controller.update([UiIds.musicGrid]);
              },
              onLongPress: () async {
                await OpenFilex.open(item.path);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.indigo.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.music_note_rounded,
                          size: 45,
                          color: Colors.indigo,
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
