class User {
  int id;
  String name;
  String avatar;
  String bio;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    bio: json["bio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "bio": bio,
  };
}