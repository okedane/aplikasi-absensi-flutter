import 'package:get/get.dart';
import 'package:test_getx/data/models/lembur/lembur_model.dart';
import 'package:test_getx/data/providers/lembur/lembur_provider.dart';

class LemburController extends GetxController {
  final lembur = Rxn<LemburModel>();
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final LemburProvider provider = LemburProvider();

  // @override
  // void onInit() {
  //   super.onInit();
  //   initializeData();
  // }

  Future<void> getLembur() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final result = await provider.getLembur();
      lembur.value = result;
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
