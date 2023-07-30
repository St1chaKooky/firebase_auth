import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:netschool/resources/auth_methods.dart';
import 'package:netschool/screens/login_screen.dart';
import 'package:netschool/utils/colors.dart';
import 'package:netschool/widgets/text_field.dart';
import 'package:flutter/services.dart';

import '../responsive/mobail_sreen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/dimensions.dart';
import '../utils/image_utils.dart';

class SiginUpScreen extends StatefulWidget {
  const SiginUpScreen({super.key});

  @override
  State<SiginUpScreen> createState() => _SiginUpScreenState();
}

class _SiginUpScreenState extends State<SiginUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  // Uint8List? _image;
  bool _isLoginLoading = false;
  bool _isGoogleLoginLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoginLoading = true;
    });
    String res = await AuthMethods().siginUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _bioController.text,
      // file: _image,
    );
    setState(() {
      _isLoginLoading = false;
    });
    if (res != "succes") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobailScreenLayout: MobailScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    }
  }

  void loginUserGoogle() async {
    setState(() {
      _isGoogleLoginLoading = true;
    });

    try {
      String res = await AuthMethods().signGoogle();

      if (res == "succes") {
        // Вход был успешным, выполните необходимые действия.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobailScreenLayout: MobailScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    } catch (e) {
      // Возникло исключение, обработаем различные типы ошибок.
      if (e is PlatformException) {
        // Это исключение PlatformException, например, из-за отмены входа через Google.
        showSnackBar("Вход через Google отменен", context);
      } else if (e is SocketException) {
        // Это исключение SocketException, возникает при проблемах с сетью.
        showSnackBar(
            "Ошибка сети. Проверьте подключение к интернету.", context);
      } else {
        // Это другое исключение, которое мы не предвидим. Обработайте его по своему усмотрению.
        showSnackBar(
            "Произошла непредвиденная ошибка. Повторите попытку позже.",
            context);
      }
      // Можно также добавить блок catch для других типов исключений, если необходимо.
    }

    setState(() {
      _isGoogleLoginLoading = false;
    });
  }

  void navigateToLogIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _userNameController,
              ),
              const SizedBox(
                height: 12,
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
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.emailAddress,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: signUpUser,
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
                    child: _isLoginLoading
                        ? const Center(
                            child: SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: whiteColor,
                            )),
                          ))
                        : const Text('Sign up',
                            style: TextStyle(
                              // fontFamily: 'WorkSans',
                              color: Colors.white,
                            ))),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => loginUserGoogle(),
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
                          side: BorderSide(color: secondaryColor, width: 1.3),
                        ),
                        color: whiteColor),
                    child: _isGoogleLoginLoading
                        ? const Center(
                            child: SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: blueColor,
                            )),
                          ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/googleLogo.png',
                                width: 17,
                                height: 17,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  // fontFamily: 'WorkSans',
                                  color: greyButtonColorText,
                                ),
                              ),
                            ],
                          )),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Text('Have an account? ',
                        style: TextStyle(
                            // fontFamily: 'WorkSans',
                            )),
                  ),
                  GestureDetector(
                    onTap: navigateToLogIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: blueColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
