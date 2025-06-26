import 'package:get/get.dart';
import '../controller/lembur_controller.dart';

class LemburBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LemburController>(() => LemburController());
  }
}