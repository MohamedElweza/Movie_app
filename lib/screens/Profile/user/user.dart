class User {
  String? image;
  String? name;
  String? email;
  String? Password;

  User({
    required this.image,
    required this.name,
    required this.email,
    required this.Password,
  });

  User copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      User(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        Password: phone ?? this.Password,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        Password: json['Password'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'Password': Password,
      };
}
