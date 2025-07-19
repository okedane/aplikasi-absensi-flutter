import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_getx/data/models/schedule/ScheduleTodayModel.dart';
import 'package:test_getx/data/providers/absensi/absensi_provider.dart';
import 'package:test_getx/data/providers/schedule/schedule_provider.dart';

class AbsensiController extends GetxController {
  final scheduleToday = Rxn<ScheduleTodayModel>();
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  // final isAbsenLoading = false.obs;
  
  Timer? _jadwalTimer;
  DateTime _lastDate = DateTime.now().toLocal().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
  );

  final ScheduleProvider provider = ScheduleProvider();
  final absensiProvider = AbsensiProvider();

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

  Future<void> absen() async {
    try {
      isLoading.value = true;

      final position = await Geolocator.getCurrentPosition();
      final response = await AbsensiProvider().submitAbsensi(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      Get.snackbar(
        "Berhasil",
        response['message'],
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Gagal Absen",
        e.toString().replaceAll('Exception:', '').trim(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
