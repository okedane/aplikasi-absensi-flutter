import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';
import 'package:test_getx/core/constants/style/app_colors.dart';
import 'package:test_getx/core/utils/formatter/date_formatter.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_appbar.dart';
import 'package:test_getx/widgets/Controller/controller_empty.dart';
import 'package:test_getx/widgets/Controller/controller_error.dart';
import 'package:test_getx/widgets/Controller/controller_loading.dart';
import 'package:test_getx/widgets/appbar/appbar_widget.dart';

class IzinView extends StatelessWidget {
  const IzinView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IzinController());

    return Obx(() {
      if (controller.isLoading.value) {
        return ControllerLoading(pesan: "Memuat data Izin");
      }

      if (controller.hasError.value) {
        return ControllerError(
          message: controller.errorMessage.value,
          onRetry: controller.refresh,
        );
      }

      final data = controller.izinList;
      if (data.isEmpty) {
        return ControllerEmpty(
          textAppbar: "Izin",
          pesan: "Tidak ada Izin bulan ",
        );
      }
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: LemburAppBar(),
        body: RefreshIndicator(
          onRefresh: () async => controller.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return Card(
                      child: ListTile(
                        title: const Text(
                          "Sakit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryLight,
                                border: Border.all(color: primaryLight),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Status",
                                style: TextStyle(
                                  color: primaryLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "${DateFormatter.formatHariTanggal(item.tanggalMulai)} s/d ${DateFormatter.formatHariTanggal(item.tanggalSelesai)}",
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 24.0),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete, size: 24.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      );
    });
  }
}
