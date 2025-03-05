class Booking {
  int propertyId;
  int userId;
  DateTime viewingTime;
  String status;
  int id;

  Booking({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.viewingTime,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      propertyId: json['property_id'],
      userId: json['user_id'],
      viewingTime: DateTime.parse(json['viewing_time']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_id': propertyId,
      'user_id': userId,
      'viewing_time': viewingTime.toIso8601String(),
      'status': status,
    };
  }
}