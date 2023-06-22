import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:netschool/resources/auth_methods.dart';
import 'package:netschool/screens/login_screen.dart';
import 'package:netschool/utils/colors.dart';
import 'package:netschool/widgets/text_field.dart';

import '../responsive/mobail_sreen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().siginUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _bioController.text,
      // file: _image,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'succes') {
      showSnakBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobailScreenLayout: MobailScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              const Text(
                'SignUp',
                style: TextStyle(
                  fontSize: 32,
                ),
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
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          )
                        : const Text('Sign up',
                            style: TextStyle(
                              color: Colors.white,
                            ))),
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
                    child: const Text('Have an account? '),
                  ),
                  GestureDetector(
                    onTap: navigateToLogIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Login',
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
