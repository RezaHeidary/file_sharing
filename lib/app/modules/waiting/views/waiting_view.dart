import 'package:file_sharing/app/core/dimens.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/waiting_controller.dart';

class WaitingView extends GetView<WaitingController> {
  const WaitingView({super.key});
  @override
  Widget build(BuildContext context) {
        final theme = Get.theme;

    return Scaffold(
      appBar: AppBar(title:  Text(LocaleKeys.receive.tr,style: theme.textTheme.titleMedium,), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: .08),
              ),
              child: CircularProgressIndicator(color: Colors.blue,padding: EdgeInsets.all(50)),

            ),
          ),

          const SizedBox(height: AppDimens.large),

           Text(
           LocaleKeys.waiting_for_sender.tr,
            style: theme.textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          Text(
          LocaleKeys.your_device_is_visible_nearby.tr,
            style:  theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
