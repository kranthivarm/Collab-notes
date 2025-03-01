class User {


  final String id;
  final String email;
  final String username;
  final String token;


  User({
    required this.id,
    required this.email,
    required this.username,
    required this.token
  });


  // convert user to json
  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'username': user.username,
      'token':user.token
    };
  }


  // convert json to user
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      token: json['token']
    );
  }


}