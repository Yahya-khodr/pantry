class User {
  String uid;
  String name;
  String email;
  bool isActive;
  String token;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.isActive,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      isActive: json['is_active'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'is_active': isActive,
      'token': token,
    };
  }
}
