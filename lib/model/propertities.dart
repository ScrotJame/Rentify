import 'images.dart';
import 'amenities.dart';
import 'user.dart';

class DetailProperty {
  int id;
  String title;
  String description;
  String location;
  String price;
  int bedrooms;
  int bathrooms;
  String? deposit;
  int area;
  String typeRestroom;
  String propertyType;
  String status;
  int userId;
  User user;
  List<Image> image;
  List<Amenity> amenities;

  DetailProperty({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    this.deposit,
    required this.area,
    required this.typeRestroom,
    required this.propertyType,
    required this.status,
    required this.userId,
    required this.user,
    required this.image,
    required this.amenities,
  });

  factory DetailProperty.fromJson(Map<String, dynamic> json) => DetailProperty(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    deposit: json["deposit"] ?? "0",
    area: json["area"],
    typeRestroom: json["type_restroom"],
    propertyType: json["property_type"],
    status: json["status"],
    userId: json["user_id"],
    user: User.fromJson(json["user"]),
    image: json["image"] != null
        ? List<Image>.from(json["image"].map((x) => Image.fromJson(x)))
        : [], // Đảm bảo image không null
    amenities: json["amenities"] != null
        ? List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x)))
        : [], // Đảm bảo amenities không null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "price": price,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "deposit": deposit,
    "area": area,
    "type_restroom": typeRestroom,
    "property_type": propertyType,
    "status": status,
    "user_id": userId,
    "user": user.toJson(),
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
    "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
  };
}

class AllProperty {
  int id;
  String title;
  String location;
  String price;
  List<Image> image;

  AllProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
  });

  factory AllProperty.fromJson(Map<String, dynamic> json) => AllProperty(
    id: json["id"],
    title: json["title"],
    location: json["location"],
    price: json["price"],
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "location": location,
    "price": price,
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

class ResultProperty {
  int id;
  String title;
  String description;
  String location;
  String price;
  int bedrooms;
  int bathrooms;
  int area;
  String typeRestroom;
  String propertyType;
  String status;
  int userId;
  List<Image> image;

  ResultProperty({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.typeRestroom,
    required this.propertyType,
    required this.status,
    required this.userId,
    required this.image,
  });

  factory ResultProperty.fromJson(Map<String, dynamic> json) => ResultProperty(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    area: json["area"],
    typeRestroom: json["type_restroom"],
    propertyType: json["property_type"],
    status: json["status"],
    userId: json["user_id"],
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "price": price,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "area": area,
    "type_restroom": typeRestroom,
    "property_type": propertyType,
    "status": status,
    "user_id": userId,
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

class Property {
  final String title;
  final String description;
  final String location;
  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final double deposit;
  final String typeRestroom;
  final String propertyType;


  Property({
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.deposit,
    required this.typeRestroom,
    required this.propertyType,
  });

  // Chuyển đổi đối tượng thành Map (không còn cần thiết với API mới)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'deposit': deposit,
      'type_restroom': typeRestroom,
      'property_type': propertyType,
    };
  }

  // Chuyển đổi từ Map thành đối tượng
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      price: double.parse(json['price'].toString()),
      bedrooms: int.parse(json['bedrooms'].toString()),
      bathrooms: int.parse(json['bathrooms'].toString()),
      area: double.parse(json['area'].toString()),
      deposit: double.parse(json['deposit'].toString()),
      typeRestroom: json['type_restroom'],
      propertyType: json['property_type'],
    );
  }
}

class AllPropertyByOwner {
  int id;
  String title;
  String location;
  String price;
  String status;
  List<Image> image;

  AllPropertyByOwner({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.image,
  });

  factory AllPropertyByOwner.fromJson(Map<String, dynamic> json) => AllPropertyByOwner(
    id: json["id"],
    title: json["title"],
    location: json["location"],
    price: json["price"],
    status: json["status"],
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "location": location,
    "price": price,
    "status": status,
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}




