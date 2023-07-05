import 'package:flutter/material.dart';

import 'package:netschool/resources/auth_methods.dart';
import 'package:netschool/screens/siginup_screen.dart';

import 'package:netschool/utils/colors.dart';
import 'package:netschool/utils/image_utils.dart';

import 'package:netschool/widgets/text_field.dart';

import '../responsive/mobail_sreen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "succes") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobailScreenLayout: MobailScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                )),
      );
    } else {
      showSnakBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SiginUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // SizedBox(
              //   height: 200,
              // ),
              const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPassword: true,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => loginUser(),
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 30),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        color: blueColor),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          )
                        : const Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // SizedBox(
              //   height: 300,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Text(
                      'Don`t have accaount? ',
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
