import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/auth/login_screen.dart';
import 'package:note_app/components/text_field_component.dart';
import 'package:note_app/functions/auth_functions.dart';
import 'package:note_app/functions/valid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    AuthFunctions authFunctions = AuthFunctions();
    return Scaffold(
      body: Container(
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
                      return validnput(val!, 3, 20);
                    },
                    hint: 'Username',
                    controller: usernameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFeildComponent(
                    valid: (val) {
                      return validnput(val!, 5, 30);
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
                      if (loading == false) {
                        setState(() {
                          loading = true;
                        });
                        if (formState.currentState!.validate()) {
                          await authFunctions.signUp(
                            context: context,
                            username: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: loading
                            ? const SpinKitPulse(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign Up',
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
                            builder: (context) => const LoginScreen(),
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
                          'Sign In',
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
