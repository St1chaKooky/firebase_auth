import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netschool/resources/auth_methods.dart';
import 'package:netschool/screens/login_screen.dart';

import 'package:netschool/utils/colors.dart';
import 'package:netschool/utils/image_utils.dart';

import '../widgets/standart_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool isLoading;
  var userData = {};
  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {
        isLoading = false;
      });
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
          userData['bio'] ?? '...',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: whiteColor,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const SizedBox(
                      height: 400,
                      child: Column(),
                    );
                  });
            },
            icon: Icon(Icons.menu),
            color: blackColor,
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                      backgroundColor: Colors.red,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      userData['username'],
                      style: const TextStyle(
                        fontSize: 14,
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: buildStatColumn(10, 'posts'),
                        ),
                        buildStatColumn(10, 'followers'),
                        Expanded(
                          child: buildStatColumn(10, 'folowing'),
                        ),
                        const SizedBox(
                          width: 10,
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
                          text: 'Выйти из аккаунта',
                          backgroundColor: greyButtonColor,
                          textColor: greyButtonColorText,
                          function: () async {
                            await AuthMethods().signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
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
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            // fontFamily: 'WorkSans'
          ),
        )
      ],
    );
  }
}
