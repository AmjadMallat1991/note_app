import 'package:flutter/material.dart';
import 'package:note_app/auth/login_Screen.dart';
import 'package:note_app/auth/signup_screen.dart';
import 'package:note_app/auth/success_screen.dart';
import 'package:note_app/home_screen.dart';
import 'package:note_app/notes/add_notes.dart';
import 'package:note_app/notes/edit_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPrefenrece;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefenrece = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: sharedPrefenrece.getString('id') == null ? 'login' : 'home',
      routes: {
        'login': (context) => const LoginScreen(),
        'signup': (context) => const SignUpScreen(),
        'home': (context) => const HomeScreen(),
        'success': (context) => const SuccessScreen(),
        'addnotes': (context) => const AddNotesScreen(),
        'editnotes': (context) => const EditNotesScreen(),
      },
    );
  }
}
