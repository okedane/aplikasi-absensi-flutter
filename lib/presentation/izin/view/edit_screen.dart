import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key});

  final controller = Get.find<IzinController>();
  final IzinModel item =
      Get.arguments; // Ambil data yang dikirim lewat Get.toNamed

  @override
  Widget build(BuildContext context) {
    // Prefill form hanya 1x saat widget dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.prefillForm(item);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Izin")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => Column(
            children: [
              TextFormField(
                readOnly: true,
                controller: controller.tanggalMulaiController,
                onTap: () => controller.selectDate(
                  context,
                  controller.tanggalMulai,
                  controller.tanggalMulaiController,
                ),
                decoration: const InputDecoration(
                  labelText: "Tanggal Mulai",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                readOnly: true,
                controller: controller.tanggalSelesaiController,
                onTap: () => controller.selectDate(
                  context,
                  controller.tanggalSelesai,
                  controller.tanggalSelesaiController,
                ),
                decoration: const InputDecoration(
                  labelText: "Tanggal Selesai",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Jenis Izin",
                  border: OutlineInputBorder(),
                ),
                value: controller.jenisIzin.value,
                items: const [
                  DropdownMenuItem(value: "sakit", child: Text("Sakit")),
                  DropdownMenuItem(value: "cuti", child: Text("Cuti")),
                  DropdownMenuItem(value: "lainnya", child: Text("Lainnya")),
                ],
                onChanged: (value) => controller.jenisIzin.value = value,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.alasanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Alasan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // validasi input
                    if (controller.tanggalMulai.value == null ||
                        controller.tanggalSelesai.value == null ||
                        controller.jenisIzin.value == null ||
                        controller.alasanController.text.isEmpty) {
                      Get.snackbar("Error", "Semua field wajib diisi");
                      return;
                    }

                    // panggil update (nanti kamu buat)
                    controller.updateIzin(
                      id: item.id,
                      tanggalMulai: controller.tanggalMulai.value!
                          .toIso8601String(),
                      tanggalSelesai: controller.tanggalSelesai.value!
                          .toIso8601String(),
                      jenisIzin: controller.jenisIzin.value!,
                      alasan: controller.alasanController.text,
                    );
                  },
                  child: const Text("Perbarui"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
