import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/model/notes_model.dart';

class CardNote extends StatelessWidget {
  const CardNote({
    super.key,
    this.ontap,
    required this.onDelete,
    required this.noteModel,
  });
  final NotesModel noteModel;
  final void Function() onDelete;

  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            // child: Image.network("$linkImageRoot/${noteModel.notesImage}"),
            child: CachedNetworkImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              fadeOutDuration: const Duration(),
              placeholderFadeInDuration: const Duration(),
              height: 100,
              width: 100,
              imageUrl: "$linkImageRoot/${noteModel.notesImage}",
              placeholder: (final context, final url) => Image.asset(
                'assets/images/logo_app.png',
              ),
              errorWidget: (
                final context,
                final url,
                final error,
              ) =>
                  Image.asset(
                'assets/images/logo_app.png',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text(noteModel.notesTitle.toString()),
              subtitle: Text(noteModel.notesContent.toString()),
              trailing: IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  size: 25,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
