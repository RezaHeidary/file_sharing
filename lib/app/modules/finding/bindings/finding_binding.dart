import 'package:get/get.dart';

import '../controllers/finding_controller.dart';

class FindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindingController>(
      () => FindingController(),
    );
  }
}
