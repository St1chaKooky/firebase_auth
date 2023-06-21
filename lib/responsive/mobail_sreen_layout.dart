import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobailScreenLayout extends StatefulWidget {
  const MobailScreenLayout({super.key});

  @override
  State<MobailScreenLayout> createState() => _MobailScreenLayoutState();
}

class _MobailScreenLayoutState extends State<MobailScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is mobail'),
      ),
    );
  }
}
