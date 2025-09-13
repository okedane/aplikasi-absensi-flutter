class ApiConstants {
  static const baseUrl = 'https://220fa5cc464c.ngrok-free.app/api';

  // Optional tambahan untuk endpoint
  static const login = '$baseUrl/login';
  static const user = '$baseUrl/user';
  static const schedule = '$baseUrl/jadwal-kerja/hari-ini';
  static const absensi = '$baseUrl/absensi';
  static const lembur = '$baseUrl/lembur';
  static const izin = '$baseUrl/izin';
  static const izinStore = '$baseUrl/izin/store';
  static const izinUpdate = '$baseUrl/izin/update';
  static const izinDelete = '$baseUrl/izin/delete';
  static const history = '$baseUrl/absensi/history';

  // forgot password
  static const forgot = '$baseUrl/forgot-password';
  static const verify = '$baseUrl/verify-code';
  static const reset = '$baseUrl/reset-password';
  static const changePassword = '$baseUrl/change-password';

  // dst...
}
