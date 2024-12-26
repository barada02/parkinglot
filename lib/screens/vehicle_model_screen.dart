import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'parking_slot_screen.dart';

class VehicleModelScreen extends StatefulWidget {
  final String userName;
  final String aadharNumber;
  final String vehicleType;

  const VehicleModelScreen({
    super.key,
    required this.userName,
    required this.aadharNumber,
    required this.vehicleType,
  });

  @override
  State<VehicleModelScreen> createState() => _VehicleModelScreenState();
}

class _VehicleModelScreenState extends State<VehicleModelScreen> {
  String? selectedModel;

  // Sample vehicle models based on type
  List<String> get vehicleModels {
    if (widget.vehicleType == '2-Wheeler') {
      return [
        'Honda Activa',
        'TVS Jupiter',
        'Bajaj Pulsar',
        'Royal Enfield Classic',
        'Hero Splendor',
        'Yamaha FZ',
        'Suzuki Access',
        'Other',
      ];
    } else {
      return [
        'Maruti Swift',
        'Hyundai i20',
        'Toyota Innova',
        'Honda City',
        'Tata Nexon',
        'Mahindra XUV',
        'Kia Seltos',
        'Other',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Vehicle Model',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your ${widget.vehicleType} model',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: vehicleModels.length,
                  itemBuilder: (context, index) {
                    final model = vehicleModels[index];
                    final isSelected = selectedModel == model;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildModelCard(model, isSelected),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: selectedModel == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParkingSlotScreen(
                              userName: widget.userName,
                              aadharNumber: widget.aadharNumber,
                              vehicleType: widget.vehicleType,
                              vehicleModel: selectedModel!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  disabledBackgroundColor: AppColors.textLight,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
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

  Widget _buildModelCard(String model, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedModel = model;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  model,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
