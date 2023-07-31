import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

String generateUniqueRandomNumber(List<String> existingNumbers) {
  final random = Random();
  const characters = '0123456789';
  const length = 6;

  String randomNumber;
  do {
    randomNumber =
        'user${String.fromCharCodes(Iterable.generate(length, (_) => characters.codeUnitAt(random.nextInt(characters.length))))}';
  } while (existingNumbers.contains(randomNumber));

  return randomNumber;
}

Future<List<String>> getExistingNumbers() async {
  final firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').get();

  final existingNumbers = querySnapshot.docs
      .map((doc) => doc['username'] as String)
      .whereType<String>()
      .toList();

  return existingNumbers;
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return _file.readAsBytes();
  }
  print('Not have image');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
