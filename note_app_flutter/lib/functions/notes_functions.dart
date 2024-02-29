import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/home_screen.dart';
import 'package:note_app/main.dart';
import 'package:note_app/services/resquests_services.dart';

class NotesFunctions {
  requestServices services = requestServices();
  viewNotes() async {
    var response = await services.postRequest(
      linkViewNotes,
      {
        "notes_users": sharedPrefenrece.getString('id'),
      },
    );

    inspect(response['notes']);
    return response;
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
  }) async {
    var response = await services.postRequest(
      linkEditNotes,
      {
        "notes_title": title,
        "notes_content": content,
        "notes_id": notesId,
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
  }) async {
    var response = await services.postRequest(
      linkDeleteNotes,
      {
        "notes_id": notesId,
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
