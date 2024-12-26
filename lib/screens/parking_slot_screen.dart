import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../models/parking_slot.dart';
import '../utils/time_slots.dart';
import '../widgets/parking_slot_widget.dart';
import 'payment_screen.dart';

class ParkingSlotScreen extends StatefulWidget {
  final String userName;
  final String aadharNumber;
  final String vehicleType;
  final String vehicleModel;

  const ParkingSlotScreen({
    super.key,
    required this.userName,
    required this.aadharNumber,
    required this.vehicleType,
    required this.vehicleModel,
  });

  @override
  State<ParkingSlotScreen> createState() => _ParkingSlotScreenState();
}

class _ParkingSlotScreenState extends State<ParkingSlotScreen> {
  ParkingSlot? selectedSlot;
  TimeSlot? selectedTimeSlot;
  final List<TimeSlot> timeSlots = TimeSlotUtils.generateTimeSlots();

  // Sample data - In a real app, this would come from a backend
  List<ParkingSlot> generateParkingSlots() {
    final slots = <ParkingSlot>[];
    final rows = ['A', 'B', 'C', 'D'];
    final slotsPerRow = 5;

    for (var row in rows) {
      for (var i = 1; i <= slotsPerRow; i++) {
        slots.add(ParkingSlot(
          id: '$row$i',
          row: row,
          number: i,
          status: i % 3 == 0 ? SlotStatus.booked : SlotStatus.available,
          isForTwoWheeler: row == 'A' || row == 'B',
        ));
      }
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final parkingSlots = generateParkingSlots();
    final isForTwoWheeler = widget.vehicleType == '2-Wheeler';

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Parking Slot',
          style: GoogleFonts.poppins(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem('Available', AppColors.accentGreen),
                  _buildLegendItem('Booked', Colors.red),
                  _buildLegendItem('Selected', AppColors.primaryBlue),
                ],
              ),
              const SizedBox(height: 24),

              // Parking Grid
              Text(
                'Parking Layout',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: parkingSlots.length,
                  itemBuilder: (context, index) {
                    final slot = parkingSlots[index];
                    final isEnabled = slot.status != SlotStatus.booked &&
                        slot.isForTwoWheeler == isForTwoWheeler;

                    return ParkingSlotWidget(
                      slot: slot.status == SlotStatus.available &&
                              selectedSlot?.id == slot.id
                          ? slot.copyWith(status: SlotStatus.selected)
                          : slot,
                      onTap: () {
                        setState(() {
                          selectedSlot = selectedSlot?.id == slot.id ? null : slot;
                        });
                      },
                      isEnabled: isEnabled,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Time Slot Selection
              Text(
                'Select Time Slot',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<TimeSlot>(
                    isExpanded: true,
                    value: selectedTimeSlot,
                    hint: Text(
                      'Select time slot',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    items: timeSlots.map((TimeSlot timeSlot) {
                      return DropdownMenuItem<TimeSlot>(
                        value: timeSlot,
                        child: Text(timeSlot.toString()),
                      );
                    }).toList(),
                    onChanged: (TimeSlot? newValue) {
                      setState(() {
                        selectedTimeSlot = newValue;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),

              // Continue Button
              ElevatedButton(
                onPressed: selectedSlot != null && selectedTimeSlot != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              slotId: selectedSlot!.id,
                              vehicleType: widget.vehicleType,
                              vehicleModel: widget.vehicleModel,
                              timeSlot: selectedTimeSlot.toString(),
                              amount: widget.vehicleType == '2-Wheeler' ? 20.0 : 40.0,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(
                  'Continue to Payment',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}
