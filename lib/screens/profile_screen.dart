import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:netschool/screens/settings_screen.dart';

import 'package:netschool/utils/colors.dart';

import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int followers = 0;
  int following = 0;
  String bio = " ";
  String username = " ";

  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      if (userSnap.exists) {
        var data = userSnap.data();
        if (data != null) {
          userData = data;
          followers = data['followers']?.length ?? 0;
          following = data['following']?.length ?? 0;
          bio = data['bio'] ?? " ";
          username = data['username'] ?? " ";
        } else {
          showSnackBar('User data is null.', context);
        }
      } else {
        showSnackBar('User not found.', context);
      }
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: blueColor,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                bio,
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: whiteColor,
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          // height: 600,
                          child: SettinsBar(),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.menu),
                  color: blackColor,
                )
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 54,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'],
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 177, 177, 177),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '@$username',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                              0,
                              'posts',
                            ),
                          ),
                          buildStatColumn(
                            followers,
                            'followers',
                          ),
                          Expanded(
                            child: buildStatColumn(
                              following,
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
                    ],
                  ),
                ),
              ],
            ));
  }
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
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: mobileSearchColor,
        ),
      ),
    ],
  );
}
