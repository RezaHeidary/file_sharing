import 'package:file_sharing/app/core/dimens.dart';
import 'package:file_sharing/app/modules/taking/widget/status_row.dart';
import 'package:file_sharing/app/modules/taking/widget/trans_fer_item.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/taking_controller.dart';

final _size = Get.size;

class TakingView extends GetView<TakingController> {
  const TakingView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      
      floatingActionButton: SizedBox(
        width: _size.width * 0.6,
        height: _size.height * .06,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.back();
          },
          backgroundColor: Colors.purple,

          label: Text(
            LocaleKeys.cancel.tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: SizedBox(),

            pinned: true,
            elevation: 0,
            centerTitle: true,
            title: Text(
              LocaleKeys.sending_files.tr,
              style: theme.textTheme.titleMedium
            ),
          ),

          /// Progress Circle
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: SizedBox(
                  height: _size.height*.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: _size.width*.55,
                        height: _size.height*.25,
                        child: CircularProgressIndicator(
                          value: .67,
                          strokeWidth: 12,
                        ),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "67%",
                            style:theme.textTheme.titleMedium?.copyWith(fontSize: 30)
                          ),
                          SizedBox(height: AppDimens.small),
                          Text(LocaleKeys.sending_files.tr,style: theme.textTheme.bodyMedium,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Status Card
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  statusRow(LocaleKeys.transferred.tr, "1.4 GB / 2.1 GB"),
                  statusRow(LocaleKeys.speed.tr, "42 MB/s"),
                  statusRow(LocaleKeys.time_left.tr, "00:24"),
                ],
              ),
            ),
          ),

          /// Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                LocaleKeys.files.tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppDimens.large)),

          /// Files List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(const [
                TransferItem(
                  fileName: "IMG_001.jpg",
                  progress: .80,
                  icon: Icons.image,
                ),

                TransferItem(
                  fileName: "Vacation.mp4",
                  progress: .35,
                  icon: Icons.video_file,
                ),

                TransferItem(
                  fileName: "Song.mp3",
                  progress: 1,
                  icon: Icons.music_note,
                ),

                TransferItem(
                  fileName: "Project.pdf",
                  progress: .55,
                  icon: Icons.picture_as_pdf,
                ),
              ]),
            ),
          ),

          /// Space for FAB
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
