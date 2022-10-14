import 'package:fdc_aj_quiz_app/helpers/app_constants.dart';
import 'package:fdc_aj_quiz_app/login/login_button.dart';
import 'package:fdc_aj_quiz_app/login/login_text_field.dart';
import 'package:fdc_aj_quiz_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Future<bool> result = ref.read(authServiceProvier).registerUser(userNameController.text, passwordController.text);
      if (!await result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed!'),
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
                          color: AppConstants.hexToColor(
                              AppConstants.appPrimaryColorGreen),
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
                          hintText: "Enter your email",
                          validator: ((value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length < 5) {
                              return "Check your email format";
                            } else if (value != null && value.isEmpty) {
                              return "Please provide an email address";
                            }
                            return null;
                          }),
                          textEditingController: userNameController,
                        ),
                        const SizedBox(height: 24),
                        LoginTextField(
                          textEditingController: passwordController,
                          obscureText: true,
                          hintText: 'Enter a password',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  LoginButton(
                    icon: FontAwesomeIcons.envelope,
                    loginMethod: () async {
                      await registerUser(context);
                    },
                    text: "Register",
                    color: AppConstants.hexToColor(
                        AppConstants.appPrimaryColorGreen),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already registered? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login', (route) => false);
                              },
                            text: 'Login',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 0, 176, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
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
