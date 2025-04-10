import 'dart:convert';
class User {
  int id;
  String name;
  String? phone;
  String avatar;
  String? bio;
  List<String> roles;

  User({
    required this.id,
    required this.name,
    this.phone,
    required this.avatar,
    this.bio,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"]as int,
    name: json["name"]as String,
    phone: json["phone"]as String?,
    avatar: json["avatar"]as String,
    bio: json["bio"]as String?,
    roles: List<String>.from(json["roles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "phone":phone,
    "bio": bio,
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}

// class UserProfile {
//   int id;
//   String name;
//   String phone;
//   String avatar;
//   dynamic bio;
//   String role;
//
//   UserProfile({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.avatar,
//     required this.bio,
//     required this.role,
//   });
//
//   factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
//     id: json["id"],
//     name: json["name"],
//     phone: json["phone"],
//     avatar: json["avatar"],
//     bio: json["bio"],
//     role: json["role"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "phone": phone,
//     "avatar": avatar,
//     "bio": bio,
//     "role": role,
//   };
// }
