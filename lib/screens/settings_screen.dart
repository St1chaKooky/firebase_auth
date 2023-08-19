import 'package:flutter/material.dart';
import 'package:netschool/resources/auth_methods.dart';
import '../widgets/text_button.dart';
import '../widgets/text_setting.dart';
import 'login_screen.dart';

class SettinsBar extends StatefulWidget {
  const SettinsBar({super.key});

  @override
  State<SettinsBar> createState() => _SettinsBarState();
}

Future<void> performSignOut(BuildContext context) async {
  // Выполните signOut и дождитесь его завершения с помощью await
  await AuthMethods().signOut();

  // После завершения signOut выполните переход на экран LoginScreen
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
}

class _SettinsBarState extends State<SettinsBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: Text('Расширенные настройки:'),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 12, right: 12),
            children: const [],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: TextButtonWidget(
              onPressed: () => performSignOut(context),
              buttonText: 'Выйти из аккаунта',
              color: Colors.red,
            )),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
