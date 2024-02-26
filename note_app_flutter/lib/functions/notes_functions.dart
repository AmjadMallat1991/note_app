import 'dart:developer';
import 'package:note_app/constant/link_api.dart';
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
}
