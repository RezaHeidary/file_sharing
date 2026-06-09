import 'package:file_sharing/app/routes/app_pages.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_controller.dart';

class SendView extends GetView<SendController> {
  const SendView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme=Get.theme;
    return Scaffold(
      appBar: AppBar(title: const Text('Send'), centerTitle: true),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            TabBar(
              isScrollable: false,
              tabs:  [
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
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
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
          ),
          child:  Text("Continue (12 items)",style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}
