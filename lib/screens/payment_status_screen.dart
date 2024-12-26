import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/payment.dart';
import '../models/digital_token.dart';
import 'digital_token_screen.dart';

class PaymentStatusScreen extends StatelessWidget {
  final PaymentStatus status;
  final String? slotId;
  final String? vehicleType;
  final String? vehicleModel;
  final String? timeSlot;
  final double? amount;

  const PaymentStatusScreen({
    Key? key,
    required this.status,
    this.slotId,
    this.vehicleType,
    this.vehicleModel,
    this.timeSlot,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  status == PaymentStatus.success
                      ? Icons.check_circle_outline
                      : Icons.error_outline,
                  size: 100,
                  color: status == PaymentStatus.success
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(height: 24),
                Text(
                  status == PaymentStatus.success
                      ? 'Payment Successful!'
                      : 'Payment Failed',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  status == PaymentStatus.success
                      ? 'Your parking slot has been booked successfully.'
                      : 'There was an error processing your payment. Please try again.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 48),
                if (status == PaymentStatus.success) ...[
                  const Text(
                    'Booking ID',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'PK12345678',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home or show digital token
                      if (status == PaymentStatus.success) {
                        final token = DigitalToken(
                          bookingId: 'PK${DateTime.now().millisecondsSinceEpoch}',
                          slotId: slotId!,
                          vehicleType: vehicleType!,
                          vehicleModel: vehicleModel!,
                          timeSlot: timeSlot!,
                          amount: amount!,
                          bookingTime: DateTime.now(),
                          qrData: 'PK${DateTime.now().millisecondsSinceEpoch}|$slotId|$timeSlot',
                        );
                        
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DigitalTokenScreen(token: token),
                          ),
                        );
                      } else {
                        Navigator.pop(context); // Go back to payment screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      status == PaymentStatus.success
                          ? 'View Digital Token'
                          : 'Try Again',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
