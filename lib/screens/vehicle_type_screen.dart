import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'vehicle_model_screen.dart';

class VehicleTypeScreen extends StatelessWidget {
  final String userName;
  final String aadharNumber;

  const VehicleTypeScreen({
    super.key,
    required this.userName,
    required this.aadharNumber,
  });

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
                'Select Vehicle Type',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your vehicle type to continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 40),
              _buildVehicleTypeCard(
                context,
                icon: Icons.two_wheeler,
                title: '2-Wheeler',
                subtitle: 'Motorcycles, Scooters',
                isSelected: false,
                onTap: () => _selectVehicleType(context, '2-Wheeler'),
              ),
              const SizedBox(height: 20),
              _buildVehicleTypeCard(
                context,
                icon: Icons.directions_car,
                title: '4-Wheeler',
                subtitle: 'Cars, SUVs',
                isSelected: false,
                onTap: () => _selectVehicleType(context, '4-Wheeler'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleTypeCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textLight,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectVehicleType(BuildContext context, String vehicleType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleModelScreen(
          userName: userName,
          aadharNumber: aadharNumber,
          vehicleType: vehicleType,
        ),
      ),
    );
  }
}
