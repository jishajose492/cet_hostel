class user {
  final String email;
  final String uid;
  final String phone;
  final String username;
  final String photourl;

  const user({
    required this.email,
    required this.phone,
    required this.photourl,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'phone': phone,
        'email': email,
        'photourl': photourl,
      };
}
