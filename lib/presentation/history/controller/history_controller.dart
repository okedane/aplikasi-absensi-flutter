import 'package:get/get.dart';
import 'package:test_getx/data/models/history/history_model.dart';
import 'package:test_getx/data/providers/history/history_provider.dart';

class HistoryController extends GetxController {
  final historyList = <AbsensiHistoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final HistoryProvider provider = HistoryProvider();

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";
      final response = await provider.getHistory();

      historyList.value = response;
    } catch (e) {
      // Debug log
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await fetchHistory();
  }
}
