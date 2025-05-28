import 'pivot.dart';
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

class AllAmenity {
  int id;
  String nameAmenities;
  String iconAmenities;

  AllAmenity({
    required this.id,
    required this.nameAmenities,
    required this.iconAmenities,
  });

  factory AllAmenity.fromJson(Map<String, dynamic> json) => AllAmenity(
    id: json["id"],
    nameAmenities: json["name_amenities"],
    iconAmenities: json["icon_amenities"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_amenities": nameAmenities,
    "icon_amenities": iconAmenities,
  };
}