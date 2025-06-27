import 'package:get/get.dart';
import 'package:test_getx/presentation/izin/view/create_screen.dart';
import 'package:test_getx/presentation/izin/view/edit_screen.dart';
import '../presentation/main/view/main_view.dart';

import './app_pages.dart';
import '../presentation/login/view/login_view.dart';
import '../presentation/home/view/home_view.dart';
import '../presentation/absensi/view/absensi_view.dart';
import '../presentation/lembur/view/lembur_view.dart';
import '../presentation/izin/view/izin_view.dart';
import '../presentation/history/view/history_view.dart';

import '../presentation/home/binding/home_binding.dart';
import '../presentation/absensi/binding/absensi_binding.dart';
import '../presentation/lembur/binding/lembur_binding.dart';
import '../presentation/izin/binding/izin_binding.dart';
import '../presentation/history/binding/history_binding.dart';
import '../presentation/login/binding/login_binding.dart';
import '../presentation/main/binding/main_binding.dart';

final List<GetPage> appPages = [
  GetPage(
    name: AppRoutes.login,
    page: () => LoginView(),
    binding: LoginBinding(),
  ),

  GetPage(
    name: AppRoutes.main,
    page: () => const MainView(),
    binding: MainBinding(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),

  GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()),
  GetPage(
    name: AppRoutes.absensi,
    page: () => AbsensiView(),
    binding: AbsensiBinding(),
  ),

  GetPage(
    name: AppRoutes.lembur,
    page: () => LemburView(),
    binding: LemburBinding(),
  ),

  GetPage(name: AppRoutes.izin, page: () => IzinView(), binding: IzinBinding()),
  GetPage(name: AppRoutes.izinCreate, page: () => CreateScreen()),
  GetPage(
    name: AppRoutes.izinEdit,
    page: () => EditScreen(),
    binding: IzinBinding(),
  ),

  GetPage(
    name: AppRoutes.history,
    page: () => HistoryView(),
    binding: HistoryBinding(),
  ),
];
