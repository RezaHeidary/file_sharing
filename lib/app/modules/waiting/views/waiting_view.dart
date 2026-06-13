import 'dart:async';

import 'package:file_sharing/app/core/dimens.dart';
import 'package:file_sharing/app/routes/app_pages.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/waiting_controller.dart';

final _size = Get.size;

class WaitingView extends GetView<WaitingController> {
  const WaitingView({super.key});
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

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.receive.tr, style: theme.textTheme.titleMedium),
        centerTitle: true,
      ),
      body: SizedBox(
        width: _size.width,
        height: _size.height * .7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Timer.periodic(Duration(seconds: 2), (time) {
                  Get.offNamed(Routes.TAKING)?.then((_) {
                    time.cancel();
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withValues(alpha: .08),
                ),
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.blue,
                  size: _size.width/4,
                ),
              ),
            ),

            const SizedBox(height: AppDimens.large),

            Text(
              LocaleKeys.waiting_for_sender.tr,
              style: theme.textTheme.titleMedium,
            ),

            const SizedBox(height: AppDimens.small),

            Text(
              LocaleKeys.your_device_is_visible_nearby.tr,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
