import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_card.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_empty.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_error.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_summary_card.dart';
import 'package:test_getx/presentation/lembur/widget/lembur_appbar.dart';
import 'package:test_getx/widgets/Controller/controller_loading.dart';

class LemburView extends GetView<LemburController> {
  const LemburView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return ControllerLoading(pesan: "Memuat data Lembur..");
      }

      if (controller.hasError.value) {
        return LemburError(
          message: controller.errorMessage.value,
          onRetry: controller.refresh,
        );
      }

      final data = controller.lemburList
        ..sort((a, b) => b.tanggal.compareTo(a.tanggal)); // Urut dari terbaru
      final limitedData = data.take(5).toList(); // Ambil 5 teratas

      if (data.isEmpty) return const LemburEmpty();

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: LemburAppBar(),
        body: RefreshIndicator(
          onRefresh: () async => controller.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LemburSummaryCard(lemburList: controller.lemburList),
                const SizedBox(height: 16),
                Text(
                  "Data Lembur",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  itemCount: limitedData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return LemburCard(item: item);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
