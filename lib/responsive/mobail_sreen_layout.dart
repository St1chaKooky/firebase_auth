import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netschool/providers/user_provider.dart';
import 'package:netschool/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import '../model/user.dart' as model;

class MobailScreenLayout extends StatefulWidget {
  const MobailScreenLayout({super.key});

  @override
  State<MobailScreenLayout> createState() => _MobailScreenLayoutState();
}

class _MobailScreenLayoutState extends State<MobailScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text(user.username),
      ),
    );
  }
}
