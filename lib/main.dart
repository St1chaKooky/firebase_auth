import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netschool/providers/user_provider.dart';
import 'package:netschool/responsive/mobail_sreen_layout.dart';
import 'package:netschool/responsive/responsive_layout.dart';
import 'package:netschool/responsive/web_screen_layout.dart';
import 'package:netschool/screens/login_screen.dart';

import 'package:netschool/utils/colors.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NetSchol',
        theme: ThemeData(
            textTheme:
                GoogleFonts.workSansTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: whiteColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobailScreenLayout: MobailScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: blackColor),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
