import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(DateTime dateTime) {
    return DateFormat('E, MMM dd yyyy').format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a E, MMM dd yyyy').format(dateTime);
  }

  static String formatDateTimeShort(DateTime dateTime) {
    return DateFormat('MMM d, hh:mm a').format(dateTime);
  }

  static String formatDay(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime);
  }

  static String formatDateYYMMDD(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatDateYYMMDDTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm').format(dateTime);
  }

  static String timeAgo(
    DateTime date, {
    bool numericDates = true,
    bool withTime = false,
  }) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    final time = DateFormat('hh:mm a').format(date);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago - $time' : 'Last week - - $time';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago - $time';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago - $time' : 'Yesterday - $time';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago - $time';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago - $time' : 'An hour ago - $time';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String timeLeft(DateTime date) {
    final date2 = DateTime.now();
    final difference = date.difference(date2);

    if ((difference.inDays / 7).floor() >= 1) {
      return '1 week Left';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days Left';
    } else if (difference.inDays >= 1) {
      return '1 day Left';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours Left';
    } else if (difference.inHours >= 1) {
      return '1 hour Left';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes Left';
    } else if (difference.inMinutes >= 1) {
      return '1 minute Left';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds Left';
    } else {
      return 'Expired';
    }
  }
}
