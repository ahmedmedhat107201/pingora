import 'package:easy_localization/easy_localization.dart';

class DateTimeFormat {
  static String formatDate(String? dateTimeString) {
    if (dateTimeString == null) return '07/22/2023';

    try {
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return '07/22/2023';
    }
  }

  static String formatTime(String? dateTimeString) {
    if (dateTimeString == null) return 'undefined'.tr();

    try {
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      final now = DateTime.now().toLocal();
      final today = DateTime(now.year, now.month, now.day).toLocal();
      final targetDay = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      ).toLocal();

      String timeString =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      if (targetDay == today) {
        return timeString;
      } else if (targetDay == today.add(Duration(days: 1))) {
        return '${'tomorrow'.tr()} $timeString';
      } else {
        return '$timeString';
      }
    } catch (e) {
      return 'undefined'.tr();
    }
  }

  static String fromTimeFormat(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp).toLocal();
      final now = DateTime.now().toLocal();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'now'.tr();
      } else if (difference.inMinutes < 60) {
        return 'time_ago_minutes'.tr(
          namedArgs: {'minutes': difference.inMinutes.toString()},
        );
      } else if (difference.inHours < 24) {
        return 'time_ago_hours'.tr(
          namedArgs: {'hours': difference.inHours.toString()},
        );
      } else if (difference.inDays < 7) {
        return 'time_ago_days'.tr(
          namedArgs: {'days': difference.inDays.toString()},
        );
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (e) {
      return timestamp;
    }
  }

  static String getDayName(int weekday) {
    switch (weekday) {
      case DateTime.sunday:
        return 'day_sunday'.tr();
      case DateTime.monday:
        return 'day_monday'.tr();
      case DateTime.tuesday:
        return 'day_tuesday'.tr();
      case DateTime.wednesday:
        return 'day_wednesday'.tr();
      case DateTime.thursday:
        return 'day_thursday'.tr();
      case DateTime.friday:
        return 'day_friday'.tr();
      case DateTime.saturday:
        return 'day_saturday'.tr();
      default:
        return '';
    }
  }
}
