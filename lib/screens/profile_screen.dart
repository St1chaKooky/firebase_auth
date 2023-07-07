import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:netschool/utils/colors.dart';
import 'package:netschool/utils/image_utils.dart';

import '../widgets/standart_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnakBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          userData['bio'],
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: whiteColor,
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(userData['photoUrl']),
                backgroundColor: Colors.red,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                userData['username'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: buildStatColumn(10, 'posts'),
                  ),
                  buildStatColumn(10, 'followers'),
                  Expanded(
                    child: buildStatColumn(10, 'folowing'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StandartButton(
                    text: 'Изменить профиль',
                    backgroundColor: greyButtonColor,
                    textColor: greyButtonColorText,
                    function: () {},
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StandartButton(
                    text: 'Изменить профиль',
                    backgroundColor: greyButtonColor,
                    textColor: greyButtonColorText,
                    function: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            // fontFamily: 'WorkSans'
          ),
        )
      ],
    );
  }
}
