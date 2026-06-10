import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceTile {
  DeviceTile._();
   static final _theme= Get.theme;

  static Widget show(String name, IconData icon) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(name,style: _theme.textTheme.bodyMedium,),
    );
  }
}
