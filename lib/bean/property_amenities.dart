class PropertyAmenities {
  final int propertyId;
  final int amenitiesId;
  final String amenityName; // Thêm tên tiện ích

  PropertyAmenities({
    required this.propertyId,
    required this.amenitiesId,
    required this.amenityName,
  });

  factory PropertyAmenities.fromJson(Map<String, dynamic> json) {
    return PropertyAmenities(
      propertyId: json['property_id'] as int,
      amenitiesId: json['amenity_id'] as int,
      amenityName: json['amenity_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_id': propertyId,
      'amenity_id': amenitiesId,
      'amenity_name': amenityName,
    };
  }
}
