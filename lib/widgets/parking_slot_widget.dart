import 'package:flutter/material.dart';
import '../models/parking_slot.dart';
import '../constants/app_colors.dart';

class ParkingSlotWidget extends StatelessWidget {
  final ParkingSlot slot;
  final VoidCallback onTap;
  final bool isEnabled;

  const ParkingSlotWidget({
    super.key,
    required this.slot,
    required this.onTap,
    required this.isEnabled,
  });

  Color _getSlotColor() {
    if (!isEnabled) return Colors.grey.shade300;
    
    switch (slot.status) {
      case SlotStatus.available:
        return AppColors.accentGreen;
      case SlotStatus.booked:
        return Colors.red;
      case SlotStatus.selected:
        return AppColors.primaryBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _getSlotColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: slot.status == SlotStatus.selected
                ? AppColors.primaryBlue
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '${slot.row}${slot.number}',
            style: TextStyle(
              color: slot.status == SlotStatus.booked
                  ? Colors.white.withOpacity(0.7)
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
