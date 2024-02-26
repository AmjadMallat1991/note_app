import 'package:flutter/material.dart';
import 'package:note_app/auth/success_screen.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/services/resquests_services.dart';

import '../home_screen.dart';

class AuthFunctions {
  requestServices services = requestServices();
  signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    var response = await services.postRequest(
      linkSignUp,
      {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    if (response != null && response.containsKey('status')) {
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(),
          ),
          (route) => false,
        );
      } else {
        // Failed signup
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'SignUp failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // Handle case where response is null or does not contain 'status' key
      print('Invalid response format');
      if (response != null) {
        print('Response Body: $response');
      }
    }
  }

  SignIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var response = await services.postRequest(
      linkSignIn,
      {
        "email": email,
        "password": password,
      },
    );

    if (response != null && response.containsKey('status')) {
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        // Failed signin
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'SignIn failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // Handle case where response is null or does not contain 'status' key
      print('Invalid response format');
      if (response != null) {
        print('Response Body: $response');
      }
    }
  }
}
