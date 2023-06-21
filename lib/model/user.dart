class User {
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final String uid;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.username,
      required this.bio,
      required this.photoUrl,
      required this.uid,
      required this.followers,
      required this.following});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
