class User {
  String? uid;
  String? name;
  String? email;
  bool? isActive;
  String? token;

  User({
     this.uid,
     this.name,
     this.email,
     this.isActive,
     this.token,
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

class Profile {
  String? id;
  String? imageUrl;
  int? weight;
  int? height;
  DateTime? birthDate;
  String? gender;

  Profile({
     this.id,
     this.imageUrl,
     this.weight,
     this.height,
     this.birthDate,
     this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'].toString(),
      imageUrl: json['image'],
      birthDate: json['birth_date'],
      weight: json['weight'],
      height: json['height'],
      gender: json['gender'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'birth_date': birthDate,
      'weight': weight,
      'height': height,
      'gender': gender,
    };
  }
}

class UserProfile {
  User? user;
  Profile? profile;

  UserProfile({
     this.user,
     this.profile,
  });
}
