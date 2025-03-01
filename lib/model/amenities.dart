import 'pivot.dart';
import 'pivot.dart';

class Amenity {
  int idAmenities;
  String nameAmenities;
  String iconAmenities;
  Pivot pivot;

  Amenity({
    required this.idAmenities,
    required this.nameAmenities,
    required this.iconAmenities,
    required this.pivot,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    idAmenities: json["id_amenities"],
    nameAmenities: json["name_amenities"],
    iconAmenities: json["icon_amenities"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name_amenities": nameAmenities,
    "icon_amenities": iconAmenities,
    "pivot": pivot.toJson(),
  };
}