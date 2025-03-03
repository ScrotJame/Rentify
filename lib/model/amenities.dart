import 'pivot.dart';
import 'dart:convert';
class Amenity {
  int id;
  String nameAmenities;
  String iconAmenities;
  Pivot pivot;

  Amenity({
    required this.id,
    required this.nameAmenities,
    required this.iconAmenities,
    required this.pivot,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    id: json["id"],
    nameAmenities: json["name_amenities"],
    iconAmenities: json["icon_amenities"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_amenities": nameAmenities,
    "icon_amenities": iconAmenities,
    "pivot": pivot.toJson(),
  };
}