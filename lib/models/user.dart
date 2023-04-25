class User {
  final int id;
  final String name;
  final String login;
  final String pwHash;

  User(
      {required this.id,
      required this.name,
      required this.pwHash,
      required this.login});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      pwHash: json['pwHash']);

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      pwHash: json['pwHash']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['id'] = id;
    user['name'] = name;
    user['login'] = login;
    user['pwHash'] = pwHash;
    return user;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'login': login, 'pwHash': pwHash};
  }
}
