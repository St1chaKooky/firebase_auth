import 'package:cloud_firestore/cloud_firestore.dart';

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
  static User? fromSnap(DocumentSnapshot? snap) {
    if (snap == null || !snap.exists) {
      return null;
    }

    var snapshot = snap.data() as Map<String, dynamic>?;

    if (snapshot == null) {
      // Обработка ситуации, когда данные в snapshot равны null.
      // Возвращаем null, чтобы указать на отсутствие данных.
      return null;
    }

    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
