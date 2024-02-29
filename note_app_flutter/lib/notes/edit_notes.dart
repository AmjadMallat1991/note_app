import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myfile;

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
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (final BuildContext context) =>
                            StatefulBuilder(
                          builder: (final context, final state) => Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Choose an option',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      XFile? file =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      myfile = File(file!.path);
                                      setState(() {});
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  Icon(CupertinoIcons.camera),
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                      thickness: 0.3, color: Colors.black54),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      try {
                                        XFile? file =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
// ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        if (file != null) {
                                          myfile = File(file.path);
                                          // Do something with myfile
                                        } else {
                                          // Handle case where user cancels image selection
                                        }
                                      } catch (e) {
                                        // Handle any errors that occur during image picking
                                        print('Error picking image: $e');
                                      }
                                      setState(() {});
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(CupertinoIcons.photo),
                                            ),
                                            Text(
                                              "Gallery",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: myfile == null ? Colors.blue[800] : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Upload',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        print(widget.notes['notes_image']);
                        await notesFunctions.editNotes(
                          context: context,
                          title: titleController.text,
                          content: contentController.text,
                          notesId: widget.notes['notes_id'].toString(),
                          myfile: myfile,
                          notesImage: widget.notes['notes_image'],
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
