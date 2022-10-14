import 'package:fdc_aj_quiz_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/app_constants.dart';
import '../services/auth.dart';
import 'login_button.dart';
import 'login_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Future<bool> result = ref.read(authServiceProvier).loginUser(userNameController.text, passwordController.text);
      _formKey.currentState!.reset();
      if (!await result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 24),
                  Stack(children: [
                    Image.asset(
                      "assets/images/flutterdevcamp2022_banner.png",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '#flutterdevcamp \nLondon \n${DateFormat.MMMMd().format(DateTime.now())} ',
                        style: TextStyle(
                          color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LoginTextField(
                          hintText: "Enter your username",
                          validator: ((value) {
                            if (value != null && value.isNotEmpty && value.length < 5) {
                              return "Your username should be more than 5 characters";
                            } else if (value != null && value.isEmpty) {
                              return "Please type your username";
                            }
                            return null;
                          }),
                          textEditingController: userNameController,
                        ),
                        const SizedBox(height: 24),
                        LoginTextField(
                          textEditingController: passwordController,
                          obscureText: true,
                          hintText: 'Enter your password',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  LoginButton(
                    icon: FontAwesomeIcons.envelope,
                    loginMethod: () async {
                      await loginUser(context);
                    },
                    text: "Login",
                    color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Not yet registered? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
                              },
                            text: 'Sign Up',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 0, 176, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LoginButton(
                    icon: FontAwesomeIcons.userNinja,
                    text: 'Continue as Guest',
                    loginMethod: AuthService().anonymousLogin,
                    color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
                  ),
                  const SizedBox(height: 24),
                  LoginButton(
                    text: 'Sign in with Google',
                    icon: FontAwesomeIcons.google,
                    color: AppConstants.hexToColor(AppConstants.appPrimaryColorAction),
                    loginMethod: AuthService().googleLogin,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
