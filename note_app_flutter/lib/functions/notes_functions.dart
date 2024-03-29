import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/home_screen.dart';
import 'package:note_app/main.dart';
import 'package:note_app/model/notes_model.dart';
import 'package:note_app/services/resquests_services.dart';

class NotesFunctions {
  requestServices services = requestServices();
  int totalPages = 0;
  List<NotesModel> notes = [];
  // viewNotes() async {
  //   var response = await services.postRequest(
  //     linkViewNotes,
  //     {
  //       "notes_users": sharedPrefenrece.getString('id'),
  //     },
  //   );

  //   inspect(response['notes']);
  //   return response;
  // }

  Future<Map<String, dynamic>> viewNotes({required int page}) async {
    try {
      var response = await services.postRequest(
        '$linkViewNotes?page=$page&limit=8',
        {
          "notes_users": sharedPrefenrece.getString('id'),
        },
      );

      notes = [];
      response['notes'].forEach((noteData) {
        notes.add(NotesModel.fromJson(noteData));
      });
      totalPages = response["total_pages"];
      inspect(notes);
      return response;
    } catch (error) {
      // Handle error
      print('Error fetching notes: $error');
      return {'error': 'Failed to fetch notes'};
    }
  }

  addNotes({
    required BuildContext context,
    required String title,
    required String content,
    required File myfile,
  }) async {
    var response = await services.postRequestFile(
      linkAddNotes,
      {
        "notes_title": title,
        "notes_content": content,
        "notes_users": sharedPrefenrece.getString('id'),
      },
      myfile,
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
                'Add Notes failed',
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

  editNotes({
    required BuildContext context,
    required String title,
    required String content,
    required String notesId,
    required String notesImage,
    required File? myfile,
  }) async {
    var response;
    if (myfile == null) {
      response = await services.postRequest(
        linkEditNotes,
        {
          "notes_title": title,
          "notes_content": content,
          "notes_id": notesId,
          "notes_image": notesImage,
        },
      );
    } else {
      response = await services.postRequestFile(
        linkEditNotes,
        {
          "notes_title": title,
          "notes_content": content,
          "notes_image": notesImage,
          "notes_id": notesId,
        },
        myfile,
      );
    }

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
                'Add Notes failed',
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

  deleteNotes({
    required BuildContext context,
    required String notesId,
    required String imageName,
  }) async {
    var response = await services.postRequest(
      linkDeleteNotes,
      {
        "notes_id": notesId,
        "notes_image": imageName,
      },
    );

    if (response != null && response.containsKey('status')) {
      if (response['status'] == "success") {
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: const Row(
            children: [
              Icon(
                Icons.verified,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Delete Notes Success',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
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
                'Delete Notes failed',
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
