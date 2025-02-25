class PropertyImage {
  final int propertyId;
  final String imageUrl;

  PropertyImage({
    required this.propertyId,
    required this.imageUrl,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      propertyId: json['property_id'] as int,
      imageUrl: json['image_url'] as String,
    );
  }

  List<PropertyImage> propertyImagesFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => PropertyImage.fromJson(json)).toList();
  }

}
