import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netschool/responsive/mobailSreenLayout.dart';
import 'package:netschool/responsive/responsiveLayout.dart';
import 'package:netschool/responsive/webScreenLayout.dart';
import 'package:netschool/utils/colors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyBfvyoyVLo916rSvocV6oqUg_6nSlx8CE0',
      appId: "1:443250163052:web:cbf8cec4dcd3aefb44c749",
      messagingSenderId: "443250163052",
      projectId: "netschool-a296d",
      storageBucket: "netschool-a296d.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
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
