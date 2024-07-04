import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = _focusNode.hasFocus ? const Offset(8, 8) : const Offset(4, 4);
    double blurRadius = _focusNode.hasFocus ? 16 : 8;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 128),
      height: 64,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            offset: -offset,
            color: Theme.of(context).colorScheme.primary,
            inset: true,
          ),
          BoxShadow(
            blurRadius: blurRadius,
            offset: offset,
            color: Theme.of(context).colorScheme.secondary,
            inset: true,
          ),
        ],
        borderRadius: BorderRadius.circular(256),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          focusNode: _focusNode,
          cursorColor: Theme.of(context).colorScheme.onSurface,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(256),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(256),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: _focusNode.hasFocus ? Colors.transparent : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
