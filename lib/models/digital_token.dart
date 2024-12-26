class DigitalToken {
  final String bookingId;
  final String slotId;
  final String vehicleType;
  final String vehicleModel;
  final String timeSlot;
  final double amount;
  final DateTime bookingTime;
  final String qrData;

  DigitalToken({
    required this.bookingId,
    required this.slotId,
    required this.vehicleType,
    required this.vehicleModel,
    required this.timeSlot,
    required this.amount,
    required this.bookingTime,
    required this.qrData,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'slotId': slotId,
      'vehicleType': vehicleType,
      'vehicleModel': vehicleModel,
      'timeSlot': timeSlot,
      'amount': amount,
      'bookingTime': bookingTime.toIso8601String(),
      'qrData': qrData,
    };
  }

  factory DigitalToken.fromJson(Map<String, dynamic> json) {
    return DigitalToken(
      bookingId: json['bookingId'],
      slotId: json['slotId'],
      vehicleType: json['vehicleType'],
      vehicleModel: json['vehicleModel'],
      timeSlot: json['timeSlot'],
      amount: json['amount'],
      bookingTime: DateTime.parse(json['bookingTime']),
      qrData: json['qrData'],
    );
  }
}
