import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/components/text_field_component.dart';
import 'package:note_app/functions/notes_functions.dart';
import 'package:note_app/functions/valid.dart';

class EditNotesScreen extends StatefulWidget {
  const EditNotesScreen({super.key, required this.notes});
  final notes;

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    titleController.text = widget.notes['notes_title'];
    contentController.text = widget.notes['notes_content'];
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
          'Edit Notes',
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
                        await notesFunctions.editNotes(
                          context: context,
                          title: titleController.text,
                          content: contentController.text,
                          notesId: widget.notes['notes_id'].toString(),
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
