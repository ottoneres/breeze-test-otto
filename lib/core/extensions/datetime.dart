extension DateTimeExtras on DateTime {
  /// Returns whether this instance is on the day of today.
  bool isToday() {
    final DateTime now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// Returns a formatted string of the date of this instance in the format DD/MM.
  /// In case this instance is today or tomorrow, it will return `today` or `tomorrow`.
  String toDateFormatOrTodayTomorrow() => isToday()
      ? 'today'
      : _isFromNow(1)
          ? 'tomorrow'
          : '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';

  /// Returns a formatted string of the time of this instance in the format XX:XX.
  String toTimeFormat() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Returns a formatted string of the date of this instance in the format DD/MM.
  String toDateFormatted() =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';

  bool _isFromNow(int days) {
    final DateTime now = DateTime.now();
    return isBefore(DateTime(now.year, now.month, now.day + days));
  }
}
