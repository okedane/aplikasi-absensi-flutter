import 'package:get/get.dart';
import 'package:test_getx/presentation/history/controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}