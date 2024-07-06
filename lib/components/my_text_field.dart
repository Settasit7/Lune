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
    final Offset offset = _focusNode.hasFocus ? const Offset(8, 8) : const Offset(4, 4);
    final double blurRadius = _focusNode.hasFocus ? 16 : 8;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            offset: offset,
            blurRadius: blurRadius,
            inset: true,
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            offset: -offset,
            blurRadius: blurRadius,
            inset: true,
          ),
        ],
      ),
      height: 64,
      duration: const Duration(milliseconds: 100),
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: _focusNode.hasFocus ? Colors.transparent : Theme.of(context).colorScheme.onSurface,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(32),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          obscureText: widget.obscureText,
          cursorColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}