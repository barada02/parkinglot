enum SlotStatus {
  available,
  booked,
  selected,
}

class ParkingSlot {
  final String id;
  final String row;
  final int number;
  final SlotStatus status;
  final bool isForTwoWheeler;

  ParkingSlot({
    required this.id,
    required this.row,
    required this.number,
    required this.status,
    required this.isForTwoWheeler,
  });

  // Create a copy of the slot with a new status
  ParkingSlot copyWith({SlotStatus? status}) {
    return ParkingSlot(
      id: id,
      row: row,
      number: number,
      status: status ?? this.status,
      isForTwoWheeler: isForTwoWheeler,
    );
  }
}
