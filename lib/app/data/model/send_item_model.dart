import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class ShareItem {
  final String id;
  final String name;
  final String path;
 final AssetEntity? asset;
 final Uint8List? iconBytes; 
   final ShareType type;

  ShareItem({
    required this.id,
    required this.name,
    required this.path,
    required this.type, this.asset, this.iconBytes,
  });
}

enum ShareType {
  app,
  photo,
  video,
  music,
  file,
}