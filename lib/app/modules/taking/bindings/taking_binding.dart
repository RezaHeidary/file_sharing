import 'package:get/get.dart';

import '../controllers/taking_controller.dart';

class TakingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakingController>(
      () => TakingController(),
    );
  }
}
