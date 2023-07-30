import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netschool/resources/auth_methods.dart';
import 'package:netschool/screens/login_screen.dart';

import 'package:netschool/utils/colors.dart';
import 'package:netschool/utils/image_utils.dart';

import '../widgets/standart_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      return userSnap.data() ??
          {}; // Возвращаем пустой Map, если данные не найдены
    } catch (e) {
      showSnackBar(e.toString(), context);
      return {}; // Возвращаем пустой Map, если произошла ошибка
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: FutureBuilder<Map<String, dynamic>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else {
              final userData = snapshot.data;
              if (userData != null && userData.containsKey('bio')) {
                return Text(
                  userData['bio'],
                  style: const TextStyle(color: Colors.black),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          },
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
                },
              );
            },
            icon: Icon(Icons.menu),
            color: blackColor,
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final userData = snapshot.data;
            if (userData == null || !userData.containsKey('username')) {
              // Обработка ситуации, если userData является null или не содержит нужных полей
              return const Center(
                child: Text('Ошибка: отсутствует информация о пользователе'),
              );
            }

            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      userData['photoUrl'] != null
                          ? CircleAvatar(
                              radius: 54,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 177, 177, 177),
                            )
                          : const CircleAvatar(
                              radius: 54,
                              backgroundColor:
                                  Color.fromARGB(255, 143, 143, 143),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        userData['username'] ?? '',
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
                            child: buildStatColumn(
                              10,
                              'posts',
                            ),
                          ),
                          buildStatColumn(
                            10,
                            'followers',
                          ),
                          Expanded(
                            child: buildStatColumn(
                              10,
                              'following',
                            ),
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
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
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
              ],
            );
          }
        },
      ),
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
          ),
        ),
      ],
    );
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
