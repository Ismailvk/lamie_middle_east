class User {
  int id;
  String username;
  String email;
  String? profileImage;
  String? profileCoverImage;
  String? phoneNumber;
  bool isGoogle;
  List<Connection>? connections;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    this.profileCoverImage,
    this.phoneNumber,
    required this.isGoogle,
    this.connections,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var connectionList = json['connections'] as List;
    List<Connection> connections =
        connectionList.map((e) => Connection.fromJson(e)).toList();

    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profile_image'],
      profileCoverImage: json['profile_cover_image'],
      phoneNumber: json['phone_number'] ?? "",
      isGoogle: json['is_google'],
      connections: connections,
    );
  }
}

class Connection {
  int id;
  String username;
  String email;
  String? profileImage;
  String? profileCoverImage;
  String? phoneNumber;
  bool isGoogle;

  Connection({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    this.profileCoverImage,
    this.phoneNumber,
    required this.isGoogle,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profile_image'],
      profileCoverImage: json['profile_cover_image'],
      phoneNumber: json['phone_number'],
      isGoogle: json['is_google'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'profile_cover_image': profileCoverImage,
      'phone_number': phoneNumber,
      'is_google': isGoogle,
    };
  }
}
