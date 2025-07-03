class Pivot {
  int propertyId;
  int amenityId;

  Pivot({
    required this.propertyId,
    required this.amenityId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    propertyId: json["property_id"],
    amenityId: json["amenity_id"],
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId,
    "amenity_id": amenityId,
  };
}