import 'package:flutter/material.dart';
import 'package:note_app/auth/login_screen.dart';
import 'package:note_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Note App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              sharedPrefenrece.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {},
              child: Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/images/logo_app.png'),
                  ),
                  const Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text('Title Note'),
                      subtitle: Text('Title Content'),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
