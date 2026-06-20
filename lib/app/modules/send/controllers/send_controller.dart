import 'dart:developer';
import 'dart:io';

import 'package:file_sharing/app/data/model/send_item_model.dart';
import 'package:file_sharing/app/modules/send/controllers/ui_ids.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_thumbnail_plus/video_thumbnail_plus.dart';

class SendController extends GetxController {
  bool isAppsLoading = true;
  bool isPhotosLoading = true;
  bool isVideosLoading = true;
  bool isMusicsLoading = true;
  bool isFilesLoading = true;

  final OnAudioQuery audioQuery = OnAudioQuery();

  final selectedItems = <ShareItem>[].obs;
  final apps = <ShareItem>[].obs;
  final photos = <ShareItem>[].obs;
  final videos = <ShareItem>[].obs;
  final musics = <ShareItem>[].obs;
  final files = <ShareItem>[].obs;
  final Map<String, String> videoThumbnails = {};

  Future<void> loadApps() async {
    isAppsLoading = true;
    update([UiIds.appGrid]);
    final result = await InstalledApps.getInstalledApps(
      withIcon: true,
      excludeSystemApps: true,
      excludeNonLaunchableApps: true,
    );

    apps.assignAll(
      result.map(
        (e) => ShareItem(
          id: e.packageName,
          name: e.name,
          path: e.packageName,
          iconBytes: e.icon,
          type: ShareType.app,
        ),
      ),
    );
    isAppsLoading = false;
    update([UiIds.appGrid]);
  }

  Future<void> loadPhotos() async {
    isPhotosLoading = true;
    update([UiIds.photoGrid]);

    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    if (albums.isNotEmpty) {
      final assets = await albums.first.getAssetListPaged(page: 0, size: 1000);

      photos.assignAll(
        assets.map(
          (e) => ShareItem(
            id: e.id,
            name: e.title ?? "",
            path: e.id,
            type: ShareType.photo,
            asset: e,
          ),
        ),
      );
    }
    isPhotosLoading = false;
    update([UiIds.photoGrid]);
  }

  Future<void> loadVideos() async {
    isVideosLoading = true;
    update([[UiIds.videoGrid]]);
    try {
      final paths = [
        '/storage/emulated/0/DCIM',
        '/storage/emulated/0/Movies',
        '/storage/emulated/0/Download',
      ];

      final result = await Future.wait(
        paths.map((path) async {
          final dir = Directory(path);

          if (!await dir.exists()) return <ShareItem>[];

          try {
            return dir
                .listSync(recursive: true) 
                .whereType<File>()
                .where(
                  (file) =>
                      file.path.toLowerCase().endsWith('.mp4') ||
                      file.path.toLowerCase().endsWith('.mkv') ||
                      file.path.toLowerCase().endsWith('.mov') ||
                      file.path.toLowerCase().endsWith('.avi') ||
                      file.path.toLowerCase().endsWith('.3gp'),
                )
                .map((file) {
                  final path = file.path;

                  return ShareItem(
                    id: path,
                    name: path.split('/').last,
                    path: path,
                    type: ShareType.video,
                  );
                })
                .toList();
          } catch (_) {
            return <ShareItem>[];
          }
        }),
        
      );

      videos.assignAll(result.expand((e) => e).toList());

      log("تعداد ویدیوهای پیدا شده با روش اسکن مستقیم حافظه: ${videos.length}");
    } catch (e) {
      log("خطا در اسکن حافظه برای ویدیوها: ${e.toString()}");
    }
    isVideosLoading = false;
    update([[UiIds.videoGrid]]);
  }

  Future<void> loadMusic() async {
    isMusicsLoading = true;
    update([[UiIds.musicGrid]]);
    final songs = await audioQuery.querySongs();
    musics.assignAll(
      songs.map(
        (e) => ShareItem(
          id: e.id.toString(),
          name: e.title,
          path: e.data,
          type: ShareType.music,
        ),
      ),
    );
    isMusicsLoading = false;
    update([[UiIds.musicGrid]]);
  }

  Future<void> loadFiles() async {
    isFilesLoading = true;
    update([[UiIds.fileGrid]]);
    final paths = [
      '/storage/emulated/0/Download',
      '/storage/emulated/0/Documents',
      '/storage/emulated/0/DCIM',
    ];

    final result = await Future.wait(
      paths.map((path) async {
        final dir = Directory(path);

        if (!await dir.exists()) return <ShareItem>[];

        try {
          return dir
              .listSync(recursive: true)
              .whereType<File>()
              .where(
                (file) =>
                    file.path.toLowerCase().endsWith('.pdf') ||
                    file.path.toLowerCase().endsWith('.doc') ||
                    file.path.toLowerCase().endsWith('.docx') ||
                    file.path.toLowerCase().endsWith('.txt') ||
                    file.path.toLowerCase().endsWith('.zip') ||
                    file.path.toLowerCase().endsWith('.xls') ||
                    file.path.toLowerCase().endsWith('.xlsx'),
              )
              .map((file) {
                final path = file.path;

                return ShareItem(
                  id: path,
                  name: path.split('/').last,
                  path: path,
                  type: ShareType.file,
                );
              })
              .toList();
        } catch (_) {
          return <ShareItem>[];
        }
      }),
    );
    files.assignAll(result.expand((e) => e).toList());
    isFilesLoading = false;
    update([[UiIds.fileGrid]]);
  }

  bool isSelected(ShareItem item) {
    return selectedItems.any((e) => e.id == item.id);
  }

  void toggleSelection(ShareItem item) {
    if (selectedItems.any((e) => e.id == item.id)) {
      selectedItems.removeWhere((e) => e.id == item.id);
    } else {
      selectedItems.add(item);
    }

    update(UiIds.sendPageAll);
  }

  Future<void> loadVideoThumbnail(String videoPath) async {
    if (videoThumbnails.containsKey(videoPath)) return;

    try {
      final tempDir = await getTemporaryDirectory();
      final fileName =
          '${videoPath.split('/').last.replaceAll('.', '_')}_thumb.jpg';
      final thumbPath = '${tempDir.path}/$fileName';

      if (await File(thumbPath).exists()) {
        videoThumbnails[videoPath] = thumbPath;
        update([[UiIds.videoGrid]]);
        return;
      }

      final String? generatedThumbPath = await VideoThumbnailPlus.thumbnailFile(
        video: videoPath,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 150,
        quality: 60,
      );

      if (generatedThumbPath != null) {
        videoThumbnails[videoPath] = generatedThumbPath;
        update([UiIds.videoGrid]); 
      }
    } catch (e) {
      log("خطا در تولید تامبنیل: $e");
    }
  }

  @override
  void onInit() async {
    super.onInit();

    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (await Permission.manageExternalStorage.isGranted ||
        await Permission.storage.isGranted) {
      await loadApps();
      await loadPhotos();
      await loadVideos();
      await loadMusic();
      await loadFiles();
    } else {
      log("دسترسی مدیریت فایل‌ها داده نشد!");
    }
  }
}
