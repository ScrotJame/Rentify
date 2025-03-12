class Booking {
  int propertyId;
  DateTime viewingTime;
  String status;

  Booking({
    required this.propertyId,
    required this.viewingTime,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      propertyId: json['property_id'],
      viewingTime: DateTime.parse(json['viewing_time']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_id': propertyId,
      'viewing_time': viewingTime.toIso8601String(),
      'status': status,
    };
  }
}