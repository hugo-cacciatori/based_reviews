class User {
  final String id;
  final String name;
  final String email;
  final String pwHash;
  final String image;

  User(
      {required this.id,
      required this.name,
      required this.pwHash,
      required this.email,
      required this.image});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      pwHash: json['pwHash'],
      image: json['image']);

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      pwHash: json['pwHash'],
      image: json['image']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['id'] = id;
    user['name'] = name;
    user['email'] = email;
    user['pwHash'] = pwHash;
    user['image'] = image;
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pwHash': pwHash,
      'image': image
    };
  }
}
