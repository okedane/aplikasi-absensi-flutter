import 'package:intl/intl.dart';

class DateFormatter {
  /// Format tanggal ISO menjadi: Senin, 25 Juni 2025
  static String formatHariTanggal(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat("EEEE, d MMMM y", "id_ID").format(date);
  }

  /// Format jam: "07:00:00" → "07:00"
  static String formatJam(String time) {
    try {
      final dateTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("HH:mm").format(dateTime);
    } catch (_) {
      return time;
    }
  }

  /// Format rentang jam: "07:00:00" - "15:00:00" → "07:00 - 15:00"
  static String formatJamRange(String masuk, String keluar) {
    return "${formatJam(masuk)} - ${formatJam(keluar)}";
  }
}
