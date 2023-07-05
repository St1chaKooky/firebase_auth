import 'package:flutter/material.dart';
import 'package:netschool/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'name',
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
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                // backgroundImage:
                //     NetworkImage('https://unsplash.com/photos/sXB9UL9-8-Q'),
              ),
              SizedBox(
                height: 15,
              ),
              Text('username'),
              SizedBox(
                height: 20,
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
              )
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
