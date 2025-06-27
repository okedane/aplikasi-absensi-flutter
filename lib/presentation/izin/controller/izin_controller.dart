import 'package:get/get.dart';
import 'package:test_getx/data/models/izin/izin_model.dart';
import 'package:test_getx/data/providers/izin/izin_provider.dart';

class IzinController extends GetxController {
  final izinList = <IzinModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final IzinProvider provider = IzinProvider();


  @override
  void onInit() {
    super.onInit();
    fetchIzin();
  }

  @override
  void refresh() async {
    await fetchIzin();
  }

  Future<void> fetchIzin() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final result = await provider.getIzin();
      izinList.assignAll(result);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
