import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:file_sharing/app/modules/send/views/tab_view/app_tab.dart';
import 'package:file_sharing/app/modules/send/views/tab_view/file_tab.dart';
import 'package:file_sharing/app/modules/send/views/tab_view/video_tab.dart';
import 'package:file_sharing/app/modules/send/views/tab_view/image_tab.dart';
import 'package:file_sharing/app/modules/send/views/tab_view/musics_tab.dart';
import 'package:file_sharing/app/routes/app_pages.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_controller.dart';

class SendView extends GetView<SendController> {
  const SendView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SendController());
    final theme = Get.theme;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Send', style: theme.textTheme.titleMedium),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 5,
          child: Column(
            children: [
              TabBar(
                labelStyle: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                isScrollable: false,
                tabs: [
                  Tab(text: LocaleKeys.app.tr),
                  Tab(text: LocaleKeys.photos.tr),
                  Tab(text: LocaleKeys.videos.tr),
                  Tab(text: LocaleKeys.music.tr),
                  Tab(text: LocaleKeys.files.tr),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AppTab(),

                    PhotosTab(),
                    VideosTab(),
                    MusicTab(),
                    FilesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<SendController>(
          id: UiIds.bottomButton,
          builder: (controller) {
            final count = controller.selectedItems.length;

            if (count == 0) {
              return const SizedBox.shrink();
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: 92,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.FINDING);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    LocaleKeys.continue_count_items.trParams({
                      'count': count.toString(),
                    }),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
