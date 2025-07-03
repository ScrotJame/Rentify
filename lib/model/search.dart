import 'package:rentify/model/propertities.dart';

class SreachProperty {
  List<ResultProperty> data;
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  SreachProperty({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory SreachProperty.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return SreachProperty(
      data: data
          .where((item) => item != null)
          .map((item) => ResultProperty.fromJson(item as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}