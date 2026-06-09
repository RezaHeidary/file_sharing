import 'package:flutter/material.dart';

class DeviceTile {
  DeviceTile._();
  static Widget show(String name, IconData icon) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(name),
    );
  }
}
