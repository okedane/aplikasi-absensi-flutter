import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return ControllerLoading(pesan: "Memuat data History");
      }

      if (controller.hasError.value) {
        return ControllerError(
          message: controller.errorMessage.value,
          onRetry: controller.refresh,
        );
      }

      final data = controller.historyList
        ..sort((a, b) => b.tanggal.compareTo(a.tanggal)); // Urut dari terbaru
      final limitedData = data.take(5).toList();
      if (data.isEmpty) {
        return ControllerEmpty(
          textAppbar: "History",
          title: "Belum ada History",
          pesan: "Tidak ada History bulan ini ",
        );
      }

      return Scaffold(
        appBar: AppBarWidget(title: "History"),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: limitedData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey[50]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(context, item),
                              SizedBox(height: 16.0),
                              Text(item.status),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildHeader(BuildContext context, AbsensiHistoryModel item) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(77, 240, 14, 168),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.calendar_today, size: 16, color: primaryColor),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          item.tanggal, // bisa diformat ke format tanggal lokal
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          item.jamAbsen,
          style: TextStyle(
            color: Colors.green[700],
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
