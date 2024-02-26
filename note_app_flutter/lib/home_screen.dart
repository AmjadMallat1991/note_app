import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/auth/login_screen.dart';
import 'package:note_app/components/card_notes_components.dart';
import 'package:note_app/functions/notes_functions.dart';
import 'package:note_app/main.dart';
import 'package:note_app/notes/add_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    NotesFunctions().viewNotes();
  }

  @override
  Widget build(BuildContext context) {
    NotesFunctions notesFunctions = NotesFunctions();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes App',
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotesScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: notesFunctions.viewNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data['status'] == 'error') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_notes.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Empty Notes...",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data['notes'].length,
                itemBuilder: (context, index) {
                  return CardNote(
                    title: snapshot.data['notes'][index]['notes_title'],
                    content: snapshot.data['notes'][index]['notes_content'],
                    ontap: () {},
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitPulse(color: Colors.blue[800]),
              );
            }
            return Center(
              child: SpinKitPulse(color: Colors.blue[800]),
            );
          },
        ),
      ),
    );
  }
}
