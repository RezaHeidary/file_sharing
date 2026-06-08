import 'package:file_sharing/app/core/theme/theme.dart';
import 'package:file_sharing/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      title: "File Transfer",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.light,
      translationsKeys: AppTranslation.translations,
    );
  }
}
