class User {
  final String name;
  final String userName;
  final String email;

  const User({required this.name, required this.email, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(name: json['name'], email: json['email'], userName: json['userName']);
    } catch (e) {
      throw e is Exception ? e : FormatException('Failed to construct User, ${e.toString()}');
    }
  }
}
