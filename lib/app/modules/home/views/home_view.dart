import 'package:file_sharing/app/core/dimens.dart';
import 'package:file_sharing/app/modules/home/widget/action_card.dart';
import 'package:file_sharing/app/modules/home/widget/file_tile.dart';
import 'package:file_sharing/app/modules/home/widget/filter_chip_widget.dart';
import 'package:file_sharing/app/routes/app_pages.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimens.large),

              Center(
                child: Text(
                 LocaleKeys.file_transfer.tr,
                  style: theme.textTheme.titleMedium,
                ),
              ),

              const SizedBox(height: AppDimens.large),

              Row(
                children: [
                  Expanded(
                    child: ActionCard.show(
                      title: LocaleKeys.send.tr,
                      subtitle: LocaleKeys.send_files_to_nearby_devices.tr,
                      icon: Icons.arrow_upward,
                      color: Colors.blue,
                      onTap: () {
                        Get.toNamed(Routes.SEND);
                        // Handle send action
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimens.medium),
                  Expanded(
                    child: ActionCard.show(
                      title: LocaleKeys.receive.tr,
                      subtitle:LocaleKeys.receive_files_from_devices.tr,
                      icon: Icons.arrow_downward,
                      color: Colors.green,
                      onTap: () {
                        // Handle receive action
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimens.large),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    FilterChipWidget(
                      title: LocaleKeys.all.tr,

                      icon: Icons.folder_copy_outlined,
                      selected: true,
                    ),
                    FilterChipWidget(
                      title: LocaleKeys.photos.tr,
                      icon: Icons.image_outlined,
                    ),
                    FilterChipWidget(
                      title: LocaleKeys.videos.tr,
                      icon: Icons.videocam_outlined,
                    ),
                    FilterChipWidget(
                      title: LocaleKeys.files.tr,
                      icon: Icons.insert_drive_file_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimens.medium),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.recent_transfers.tr, style: theme.textTheme.bodyLarge),
                  TextButton(onPressed: () {}, child:  Text(LocaleKeys.see_all.tr)),
                ],
              ),

              const SizedBox(height: AppDimens.medium),

              FileTile.show(
                icon: Icons.image,
                color: Colors.blue,
                fileName: "IMG_20240520.jpg",
                device: "Galaxy S23",
                size: "2.4 MB",
                onPressed: () {},
              ),

              FileTile.show(
                icon: Icons.play_circle_fill,
                color: Colors.deepPurple,
                fileName: "VID_20240520.mp4",
                device: "iPhone 14",
                size: "24.8 MB",
                onPressed: () {},
              ),

              FileTile.show(
                icon: Icons.picture_as_pdf,
                color: Colors.red,
                fileName: "Project.pdf",
                device: "Windows PC",
                size: "1.8 MB",
                onPressed: () {},
              ),

              FileTile.show(
                icon: Icons.description,
                color: Colors.indigo,
                fileName: "Report.docx",
                device: "MacBook Pro",
                size: "320 KB",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
