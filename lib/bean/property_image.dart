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

  Map<String, dynamic> toJson() { // Thêm phương thức toJson() ở đây
    return {
      'property_id': propertyId,
      'image_url': imageUrl,
    };

}
}
