import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

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
          // onRetry: controller.refresh,
          onRetry: () => controller.fetchIzin(),
        );
      }

      final data = controller.izinList;
      if (data.isEmpty) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBarWidget(title: "Izin"),
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: whiteC,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.access_time_outlined,
                      size: 48,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Izin",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tidak ada data Izin",
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                ],
              ),
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
      }

      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBarWidget(title: "Daftar Izin"),
        body: RefreshIndicator(
          onRefresh: () async => controller.fetchIzin(),
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
                          Get.toNamed(AppRoutes.izinEdit, arguments: item);
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
              Get.back();
              final controller = Get.find<IzinController>();
              controller.deleteIzin(item.id);
              Get.back();
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
