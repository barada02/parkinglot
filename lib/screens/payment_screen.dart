import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/payment.dart';
import 'payment_status_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String slotId;
  final String vehicleType;
  final String vehicleModel;
  final String timeSlot;
  final double amount;

  const PaymentScreen({
    Key? key,
    required this.slotId,
    required this.vehicleType,
    required this.vehicleModel,
    required this.timeSlot,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.upi;

  Widget _buildPaymentMethodCard(PaymentMethod method, String title, IconData icon) {
    return Card(
      elevation: _selectedMethod == method ? 4 : 1,
      color: _selectedMethod == method ? AppColors.primaryBlue.withOpacity(0.1) : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedMethod = method;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: _selectedMethod == method ? AppColors.primaryBlue : Colors.grey,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: _selectedMethod == method ? FontWeight.bold : FontWeight.normal,
                  color: _selectedMethod == method ? AppColors.primaryBlue : Colors.black87,
                ),
              ),
              const Spacer(),
              Radio<PaymentMethod>(
                value: method,
                groupValue: _selectedMethod,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _selectedMethod = value!;
                  });
                },
                activeColor: AppColors.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Slot ID', widget.slotId),
                    _buildSummaryRow('Vehicle Type', widget.vehicleType),
                    _buildSummaryRow('Vehicle Model', widget.vehicleModel),
                    _buildSummaryRow('Time Slot', widget.timeSlot),
                    const Divider(),
                    _buildSummaryRow(
                      'Amount',
                      '₹${widget.amount.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Payment Methods
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentMethodCard(
              PaymentMethod.upi,
              'UPI Payment',
              Icons.account_balance,
            ),
            const SizedBox(height: 8),
            _buildPaymentMethodCard(
              PaymentMethod.card,
              'Credit/Debit Card',
              Icons.credit_card,
            ),
            const SizedBox(height: 8),
            _buildPaymentMethodCard(
              PaymentMethod.wallet,
              'Wallet',
              Icons.account_balance_wallet,
            ),
            const SizedBox(height: 24),
            
            // Pay Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement payment processing
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentStatusScreen(
                        status: PaymentStatus.success,
                        slotId: widget.slotId,
                        vehicleType: widget.vehicleType,
                        vehicleModel: widget.vehicleModel,
                        timeSlot: widget.timeSlot,
                        amount: widget.amount,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primaryBlue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
