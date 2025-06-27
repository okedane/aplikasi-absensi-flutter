import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';
import 'package:test_getx/core/constants/style/app_colors.dart';
import 'package:test_getx/presentation/izin/widget/izin_card.dart';
import 'package:test_getx/presentation/izin/widget/stat_card.dart';
import 'package:test_getx/routes/app_pages.dart';
import 'package:test_getx/widgets/Controller/controller_empty.dart';
import 'package:test_getx/widgets/Controller/controller_error.dart';
import 'package:test_getx/widgets/Controller/controller_loading.dart';
import 'package:test_getx/widgets/appbar/appbar_widget.dart';

class IzinView extends GetView<IzinController> {
  const IzinView({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: "Belum ada Izin",
          pesan: "Tidak ada Izin bulan ini ",
        );
      }

      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBarWidget(title: "Daftar Izin"),
        body: RefreshIndicator(
          onRefresh: () async => controller.refresh(),
          color: primaryColor,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Header Section dengan statistik
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatCard(
                        title: "Total Izin",
                        value: "${data.length}",
                        icon: Icons.list_alt,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: whiteC.withOpacity(0.3),
                      ),
                      StatCard(
                        title: "Bulan ini",
                        value: "${data.length}",
                        icon: Icons.calendar_month,
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = data[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: IzinCard(
                        item: item,
                        onTap: () {
                          // Navigasi ke detail atau dialog
                        },
                        onEdit: () {
                          // Navigasi ke halaman edit izin
                        },
                        onDelete: () {
                          _showDeleteDialog(item); // Fungsi ini sudah kamu buat
                        },
                      ),
                    );
                  }, childCount: data.length),
                ),
              ),

              // Bottom Spacing
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            foregroundColor: whiteC,
            onPressed: () {
              controller.resetForm(); 
              Get.toNamed(AppRoutes.izinCreate);
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              "Tambah Izin",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    });
  }

  void _showDeleteDialog(dynamic item) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Hapus Izin",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Apakah Anda yakin ingin menghapus izin \"${item.jenisIzin}\"?",
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              // Handle delete action
              Get.back();
              Get.snackbar(
                "Berhasil",
                "Izin berhasil dihapus",
                backgroundColor: successColor,
                colorText: whiteC,
                snackPosition: SnackPosition.TOP,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: dangerColor,
              foregroundColor: whiteC,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }
}
