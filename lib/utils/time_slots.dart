class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({required this.startTime, required this.endTime});

  @override
  String toString() => '$startTime - $endTime';
}

class TimeSlotUtils {
  static List<TimeSlot> generateTimeSlots() {
    // Generate time slots from 9 AM to 6 PM with 1-hour intervals
    final slots = <TimeSlot>[];
    final startHour = 9; // 9 AM
    final endHour = 18; // 6 PM

    for (var hour = startHour; hour < endHour; hour++) {
      final startTime = _formatHour(hour);
      final endTime = _formatHour(hour + 1);
      slots.add(TimeSlot(startTime: startTime, endTime: endTime));
    }

    return slots;
  }

  static String _formatHour(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : hour;
    return '$displayHour:00 $period';
  }
}
