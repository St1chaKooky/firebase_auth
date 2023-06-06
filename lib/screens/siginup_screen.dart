import 'package:flutter/material.dart';
import 'package:netschool/utils/colors.dart';
import 'package:netschool/widgets/text_field.dart';

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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
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
              const Text('SignUp'),
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
                onTap: () => print('1'),
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        color: blueColor),
                    child: const Text('Log in',
                        style: TextStyle(color: Colors.white))),
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
                    child: const Text('Don`t have accaount? '),
                  ),
                  GestureDetector(
                    onTap: () => print('2'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Sign Up',
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
