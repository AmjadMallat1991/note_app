import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:note_app/auth/login_screen.dart';
import 'package:note_app/components/card_notes_components.dart';
import 'package:note_app/functions/notes_functions.dart';
import 'package:note_app/main.dart';
import 'package:note_app/model/notes_model.dart';
import 'package:note_app/notes/add_notes.dart';
import 'package:note_app/notes/edit_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  final PagingController<int, NotesModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  Future<void> _fetchPage(int pageKey) async {
    NotesFunctions notesFunctions = NotesFunctions();
    try {
      await notesFunctions.viewNotes(page: pageKey);

      final isLastPage = pageKey >= notesFunctions.totalPages;

      if (isLastPage) {
        _pagingController.appendLastPage(notesFunctions.notes);
      } else {
        pageKey += 1;
        _pagingController.appendPage(notesFunctions.notes, pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
      body: Container(
        height: double.maxFinite,
        child: PagedListView<int, NotesModel>(
          shrinkWrap: true,
          pagingController: _pagingController,
          physics: const ClampingScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<NotesModel>(
            newPageProgressIndicatorBuilder: (context) => SpinKitThreeBounce(
              color: Colors.blue[800],
              size: 25.0,
            ),
            firstPageProgressIndicatorBuilder: (context) => SpinKitPulse(
              color: Colors.blue[800],
            ),
            itemBuilder: (context, item, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardNote(
                  onDelete: () async {
                    await notesFunctions.deleteNotes(
                      context: context,
                      notesId: item.notesId.toString(),
                      imageName: item.notesImage.toString(),
                    );
                    _pagingController.refresh();
                  },
                  noteModel: item,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNotesScreen(
                          notes: item,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: FutureBuilder(
      //     future: notesFunctions.viewNotes(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData) {
      //         if (snapshot.data['status'] == 'error') {
      //           return Padding(
      //             padding: const EdgeInsets.only(bottom: 40.0),
      //             child: Center(
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Image.asset(
      //                     'assets/images/empty_notes.png',
      //                     width: 250,
      //                     height: 250,
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   const Text(
      //                     "Empty Notes...",
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.w600,
      //                       letterSpacing: 0.6,
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           );
      //         }
      //         return ListView.builder(
      //           itemCount: snapshot.data['notes'].length,
      //           itemBuilder: (context, index) {
      //             return CardNote(
      //               onDelete: () {
      //                 notesFunctions.deleteNotes(
      //                   context: context,
      //                   notesId: snapshot.data['notes'][index]['notes_id']
      //                       .toString(),
      //                   imageName: snapshot.data['notes'][index]['notes_image'],
      //                 );
      //                 setState(() {});
      //               },
      //               noteModel:
      //                   NotesModel.fromJson(snapshot.data['notes'][index]),
      //               ontap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => EditNotesScreen(
      //                       notes: snapshot.data['notes'][index],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //         );
      //       }
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: SpinKitPulse(color: Colors.blue[800]),
      //         );
      //       }
      //       return Center(
      //         child: SpinKitPulse(color: Colors.blue[800]),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
