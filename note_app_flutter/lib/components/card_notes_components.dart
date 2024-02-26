import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  const CardNote({
    super.key,
    this.ontap,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

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
            child: Image.asset('assets/images/logo_app.png'),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text(title),
              subtitle: Text(content),
            ),
          ),
        ],
      )),
    );
  }
}