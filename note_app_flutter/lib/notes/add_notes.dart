import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/components/text_field_component.dart';
import 'package:note_app/functions/notes_functions.dart';
import 'package:note_app/functions/valid.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    NotesFunctions notesFunctions = NotesFunctions();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/add_notes.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFeildComponent(
                    hint: 'Title',
                    controller: titleController,
                    valid: (val) {
                      return validnput(val!, 3, 10);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFeildComponent(
                    hint: 'Content',
                    controller: contentController,
                    valid: (val) {
                      return validnput(val!, 10, 300);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      if (formState.currentState!.validate()) {
                        await notesFunctions.addNotes(
                          context: context,
                          title: titleController.text,
                          content: contentController.text,
                        );
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 250,
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
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  fontSize: 20,
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
