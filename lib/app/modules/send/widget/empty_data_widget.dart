import 'package:file_sharing/app/modules/send/controllers/send_controller.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyDataWidget extends GetView<SendController> {
  const EmptyDataWidget({super.key, this.onPressed});
  final  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_neutral_rounded, color: Colors.amber, size: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.we_cant_not_found_data.tr),
              TextButton(
                onPressed: onPressed,
                child: Text(LocaleKeys.try_again.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
