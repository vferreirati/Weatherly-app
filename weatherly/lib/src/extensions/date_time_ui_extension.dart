/// Provides UI extensions.
extension DateTimeUIExtension on DateTime {
  /// Returns wheter or not a date is the same as of today.
  bool get isToday {
    final now = DateTime.now();
    final current = DateTime(year, month, day);
    final withoutHours = DateTime(now.year, now.month, now.day);

    return current.difference(withoutHours).inDays == 0;
  }
}
