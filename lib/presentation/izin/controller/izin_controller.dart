import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_getx/core/constants/style/app_colors.dart';
import 'package:test_getx/data/models/izin/izin_model.dart';
import 'package:test_getx/data/providers/izin/izin_provider.dart';

class IzinController extends GetxController {
  final izinList = <IzinModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final tanggalMulai = Rxn<DateTime>();
  final tanggalSelesai = Rxn<DateTime>();
  final jenisIzin = RxnString();
  final tanggalMulaiController = TextEditingController();
  final tanggalSelesaiController = TextEditingController();
  final alasanController = TextEditingController();

  final IzinProvider provider = IzinProvider();

  @override
  void onInit() {
    super.onInit();
    fetchIzin();
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

  Future<void> createIzin({
    required String tanggalMulai,
    required String tanggalSelesai,
    required String jenisIzin,
    required String alasan,
  }) async {
    try {
      isLoading.value = true;
      await provider.createIzin(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        jenisIzin: jenisIzin,
        alasan: alasan,
      );
      await fetchIzin();
      resetForm();
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Pengajuan izin berhasil disimpan",
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } catch (e) {
      Get.snackbar(
        "Gagal",
        e.toString(),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
    }
  }

  void prefillForm(IzinModel item) {
    tanggalMulai.value = DateTime.parse(item.tanggalMulai);
    tanggalSelesai.value = DateTime.parse(item.tanggalSelesai);
    tanggalMulaiController.text = item.tanggalMulai;
    tanggalSelesaiController.text = item.tanggalSelesai;
    jenisIzin.value = item.jenisIzin;
    alasanController.text = item.alasan;
  }

  Future<void> updateIzin({
    required int id,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String jenisIzin,
    required String alasan,
  }) async {
    try {
      isLoading.value = true;
      await provider.updateIzin(
        id: id,
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        jenisIzin: jenisIzin,
        alasan: alasan,
      );
      await fetchIzin();
      resetForm();
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Data izin berhasil diperbarui",
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } catch (e) {
      Get.snackbar(
        "Gagal",
        e.toString(),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteIzin(int id) async {
    try {
      isLoading.value = true;
      await provider.deleteIzin(id);
      await fetchIzin();
      Get.snackbar(
        "Berhasil",
        "Izin berhasil dihapus",
        backgroundColor: successColor,
        colorText: whiteC,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        "Gagal",
        e.toString(),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    tanggalMulai.value = null;
    tanggalSelesai.value = null;
    jenisIzin.value = null;
    tanggalMulaiController.clear();
    tanggalSelesaiController.clear();
    alasanController.clear();
  }

  Future<void> selectDate(
    BuildContext context,
    Rxn<DateTime> rxDate,
    TextEditingController textController,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      rxDate.value = picked;
      textController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}
