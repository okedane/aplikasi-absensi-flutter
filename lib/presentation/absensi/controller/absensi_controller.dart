import 'dart:async';

import 'package:get/get.dart';
import 'package:test_getx/data/models/schedule/ScheduleTodayModel.dart';
import 'package:test_getx/data/providers/schedule/schedule_provider.dart';

class AbsensiController extends GetxController {
  final scheduleToday = Rxn<ScheduleTodayModel>();
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  Timer? _jadwalTimer;
  DateTime _lastDate = DateTime.now().toLocal().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
  );

  final ScheduleProvider provider = ScheduleProvider();

  Future<void> fetchTodaySchedule() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final result = await provider.getTodaySchedule();
      scheduleToday.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTodaySchedule();

    _jadwalTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      final now = DateTime.now().toLocal().copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
      );

      if (!_lastDate.isAtSameMomentAs(now)) {
        _lastDate = now;
        fetchTodaySchedule(); // hari telah berganti
      }
    });
  }

  @override
  void onClose() {
    _jadwalTimer?.cancel();
    super.onClose();
  }
}
