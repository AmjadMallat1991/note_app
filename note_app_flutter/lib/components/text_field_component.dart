import 'package:flutter/material.dart';

class TextFeildComponent extends StatefulWidget {
  const TextFeildComponent({
    super.key,
    required this.hint,
    required this.controller,
    required this.valid,
  });
  final String? Function(String?) valid;
  final String hint;
  final TextEditingController controller;

  @override
  State<TextFeildComponent> createState() => _TextFeildComponentState();
}

class _TextFeildComponentState extends State<TextFeildComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.valid,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
