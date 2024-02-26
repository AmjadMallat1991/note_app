import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/auth/signup_screen.dart';
import 'package:note_app/components/text_field_component.dart';
import 'package:note_app/functions/auth_functions.dart';
import 'package:note_app/home_screen.dart';

import '../functions/valid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    AuthFunctions authFunctions = AuthFunctions();
    return Scaffold(
      body: loading
          ? const Center(
              child: SpinKitPulse(
                color: Colors.white,
              ),
            )
          : Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_app.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFeildComponent(
                          valid: (val) {
                            return validnput(val!, 5, 20);
                          },
                          hint: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFeildComponent(
                          valid: (val) {
                            return validnput(val!, 3, 10);
                          },
                          hint: 'Password',
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            if (formState.currentState!.validate()) {
                              await authFunctions.SignIn(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                                (route) => false);
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
