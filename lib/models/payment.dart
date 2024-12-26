enum PaymentMethod { upi, card, wallet }

enum PaymentStatus { pending, success, failed }

class Payment {
  final String bookingId;
  final double amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime timestamp;

  Payment({
    required this.bookingId,
    required this.amount,
    required this.method,
    this.status = PaymentStatus.pending,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'amount': amount,
      'method': method.toString(),
      'status': status.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      bookingId: json['bookingId'],
      amount: json['amount'],
      method: PaymentMethod.values.firstWhere(
        (e) => e.toString() == json['method'],
      ),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
