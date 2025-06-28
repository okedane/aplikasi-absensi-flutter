import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/data/models/user/user_profile_model..dart';
import 'package:test_getx/data/providers/user/user_provider.dart';
import 'package:test_getx/routes/app_pages.dart';

class HomeController extends GetxController {
  final user = Rxn<UserProfileModel>(); // data user
  final isLoading = false.obs; // status loading
  final error = ''.obs; // error message
  final storage = GetStorage();

  final userProvider = UserProvider();

  @override
  void onInit() {
    super.onInit();
    fetchUser(); // ambil data user saat controller dibuat
  }

  @override
  void refresh() async {
    fetchUser();
  }

  void fetchUser() async {
    try {
      isLoading.value = true;
      final result = await userProvider.fetchUser();
      user.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Gagal mengambil data user');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    storage.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
