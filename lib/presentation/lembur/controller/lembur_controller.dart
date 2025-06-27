import 'package:get/get.dart';
import 'package:test_getx/data/models/lembur/lembur_model.dart';
import 'package:test_getx/data/providers/lembur/lembur_provider.dart';

class LemburController extends GetxController {
  final lemburList = <LemburModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final LemburProvider provider = LemburProvider();

  @override
  void onInit() {
    super.onInit();
    getLembur();
  }

  Future<void> getLembur() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final result = await provider
          .getLembur(); 
      lemburList.assignAll(result);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void refresh() async {
    await getLembur();
  }
}
