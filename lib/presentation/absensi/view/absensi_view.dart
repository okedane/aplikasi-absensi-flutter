import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core/constants/style/app_colors.dart';
import 'package:test_getx/core/utils/formatter/date_formatter.dart';
import 'package:test_getx/presentation/absensi/controller/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<AbsensiController>;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (controller.hasError.value) {
        return Scaffold(
          body: Center(child: Text("Error: ${controller.errorMessage.value}")),
        );
      }
      final data = controller.scheduleToday.value;
      if (data == null) {
        return const Center(child: Text("Tidak ada jadwal hari ini."));
      }

      return Scaffold(
        appBar: AppBar(title: const Text("Absensi"), actions: const []),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 195,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [primaryLight, primaryColor],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: -15,
                    right: -15,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.work_outline, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(
                                  "Shift ${data.shift}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  // Senin, 25 Juli 2025
                                  DateFormatter.formatHariTanggal(data.tanggal),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_filled,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  "${DateFormatter.formatJam(data.jamMasuk)} - ${DateFormatter.formatJam(data.jamKeluar)}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16.0),
                        Divider(
                          color: Colors.white.withOpacity(0.3),
                          thickness: 1,
                        ),

                        const SizedBox(height: 8.0),
                        Center(
                          child: Text(
                            data.lokasi.namaLokasi,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),

                  child: Text(
                    "Absen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: whiteC,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
