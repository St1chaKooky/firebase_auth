import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user.dart' as model;
import '../utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User?> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sing up user
  Future<String> siginUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file, // Обновленная сигнатура поля file
  }) async {
    String res = "Some error occured";
    try {
      if ((email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty) &&
          isStrongPassword(password)) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = "https://i.stack.imgur.com/l60Hf.png";
        // if (file != null) {
        //   photoUrl = await StorageMethods()
        //       .uploadImageToStorage('profilePics', file, false);
        // }

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        //add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "succes";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "succes";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  //GoogleAuntification
  Future<String> signGoogle() async {
    List<String> existingNumbers = await getExistingNumbers();
    String res = "Some error occurred";

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      // Проверяем, есть ли у пользователя уже документ в Firestore
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid);
      final userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        // Если документа еще нет (пользователь зарегистрировался впервые), создаем его с полями по умолчанию
        await userRef.set({
          "email": _auth.currentUser!.email,
          "username": generateUniqueRandomNumber(
              existingNumbers), // Значение по умолчанию для username
          "bio": "Your text", // Значение по умолчанию для bio
          "photoUrl":
              "https://i.stack.imgur.com/l60Hf.png", // Пустое значение для поля photoUrl
          "uid": _auth.currentUser!.uid,
          "followers": [],
          "following": [],
        });
      }
      res = "succes";
    }

    return res;
  }
}

bool isStrongPassword(String password) {
  // Шаг 1: Проверить длину пароля (от 6 до 20 символов)
  if (password.length < 6 || password.length > 20) {
    return false;
  }

  // Шаг 2: Проверить наличие больших и строчных букв
  bool hasUpperCase = false;
  bool hasLowerCase = false;

  for (int i = 0; i < password.length; i++) {
    if (password[i].toUpperCase() != password[i]) {
      hasLowerCase = true;
    } else if (password[i].toLowerCase() != password[i]) {
      hasUpperCase = true;
    }

    // Если оба условия выполняются, можно прервать цикл, так как все условия уже проверены
    if (hasUpperCase && hasLowerCase) {
      break;
    }
  }

  if (!hasUpperCase || !hasLowerCase) {
    return false;
  }

  // Шаг 3: Проверить наличие пробелов и специальных знаков
  RegExp specialChars = RegExp(r'[!@#%^&*(),.?":{}|<>]');
  if (password.contains(' ') || specialChars.hasMatch(password)) {
    return false;
  }

  // Если все условия выполнились, пароль считается сильным
  return true;
}
