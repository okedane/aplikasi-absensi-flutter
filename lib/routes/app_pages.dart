abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verifyCode = '/verify-code';
  static const resetPassword = '/reset-password';

  static const main = '/main';
  static const home = '/home';

  static const absensi = '/absensi';
  // CRUD Lembur
  static const lembur = '/lembur'; // list
  static const lemburCreate = '/lembur/create';
  static const lemburEdit = '/lembur/edit'; // bisa pakai parameter juga
  static const lemburDetail = '/lembur/detail';

  // CRUD Izin
  static const izin = '/izin';
  static const izinCreate = '/izin/create';
  static const izinEdit = '/izin/edit';
  static const izinDetail = '/izin/detail';

  static const history = '/history';

  static const profile = '/profile';
  static const changePassword = '/change-password';
}
