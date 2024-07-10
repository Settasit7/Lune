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
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            offset: _focusNode.hasFocus ? Offset(MediaQuery.of(context).size.height * 0.008, MediaQuery.of(context).size.height * 0.008) : Offset(MediaQuery.of(context).size.height * 0.004, MediaQuery.of(context).size.height * 0.004),
            blurRadius: _focusNode.hasFocus ? MediaQuery.of(context).size.height * 0.018 : MediaQuery.of(context).size.height * 0.008,
            inset: true,
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            offset: _focusNode.hasFocus ? Offset(-MediaQuery.of(context).size.height * 0.008, -MediaQuery.of(context).size.height * 0.008) : Offset(-MediaQuery.of(context).size.height * 0.004, -MediaQuery.of(context).size.height * 0.004),
            blurRadius: _focusNode.hasFocus ? MediaQuery.of(context).size.height * 0.018 : MediaQuery.of(context).size.height * 0.008,
            inset: true,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.068,
      duration: const Duration(milliseconds: 100),
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: _focusNode.hasFocus ? Colors.transparent : Theme.of(context).colorScheme.onSurface),
            contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.034),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
            ),
          ),
          obscureText: widget.obscureText,
          cursorColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}