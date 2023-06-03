import 'package:flutter/material.dart';
import 'package:netschool/responsive/mobailSreenLayout.dart';
import 'package:netschool/responsive/responsiveLayout.dart';
import 'package:netschool/responsive/webScreenLayout.dart';
import 'package:netschool/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NetSchol',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const ResponsiveLayout(
          mobailScreenLayout: MobailScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
