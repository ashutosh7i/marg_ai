class User {
  final String id;
  final String username;
  final String email;
  String? name;
  String? bio;
  String? studentClass;
  String? profilePictureUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.bio,
    this.studentClass,
    this.profilePictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'],
      studentClass: json['studentClass'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'bio': bio,
      'studentClass': studentClass,
      'profilePictureUrl': profilePictureUrl,
    };
  }
} 