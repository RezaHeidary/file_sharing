import 'package:file_sharing/app/core/dimens.dart';
import 'package:file_sharing/app/modules/finding/widget/device_tile.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/finding_controller.dart';

final _size = Get.size;

class FindingView extends GetView<FindingController> {
  const FindingView({super.key});
  @override
  Widget build(BuildContext context) {
  final theme=  Get.theme;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.finding.tr,style: theme.textTheme.titleMedium,), centerTitle: true),
        body: Column(
          children: [
            const Spacer(),
      
            Container(
              width: _size.width*.5,
              height: _size.height*.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: .08),
              ),
              child: const Icon(
                Icons.wifi_tethering,
                size: 100,
                color: Colors.blue,
              ),
            ),
      
            const SizedBox(height: AppDimens.large),
      
            Text(
              LocaleKeys.looking_for_nearby_devices.tr,
              style:theme.textTheme.titleMedium,
            ),
      
            const SizedBox(height: AppDimens.medium),
      
            Text(
              LocaleKeys.make_sure_the_receiver_is_ready.tr,
                 style: theme.textTheme.bodyMedium,
            ),
      
            const Spacer(),
      
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.nearby_devices.tr,
                    style: theme.textTheme.titleMedium,
                  ),
      
                  const SizedBox(height: AppDimens.large),
      
                  DeviceTile.show("Galaxy S24", Icons.phone_android),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
