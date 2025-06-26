import 'package:get/get.dart';
import 'package:test_getx/presentation/izin/controller/izin_controller.dart';

class IzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinController>(() => IzinController());
  }
}