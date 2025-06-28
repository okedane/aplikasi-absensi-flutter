import 'package:get/get.dart';
import 'package:test_getx/core.dart';
// import 'package:test_getx/core.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
