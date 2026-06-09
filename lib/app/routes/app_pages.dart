import 'package:get/get.dart';

import '../modules/finding/bindings/finding_binding.dart';
import '../modules/finding/bindings/finding_binding.dart';
import '../modules/finding/views/finding_view.dart';
import '../modules/finding/views/finding_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/send/bindings/send_binding.dart';
import '../modules/send/views/send_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEND,
      page: () => const SendView(),
      binding: SendBinding(),
    ),
    GetPage(
      name: _Paths.FINDING,
      page: () => const FindingView(),
      binding: FindingBinding(),
      children: [
        GetPage(
          name: _Paths.FINDING,
          page: () => const FindingView(),
          binding: FindingBinding(),
        ),
      ],
    ),
  ];
}
