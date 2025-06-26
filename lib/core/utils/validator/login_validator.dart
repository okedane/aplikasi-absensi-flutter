class LoginValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi.';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Format email tidak valid.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password wajib diisi.';
    }
    if (value.length < 7) {
      return 'Password minimal 7 karakter.';
    }
    return null;
  }
}
