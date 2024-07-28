import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  const MessageField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
  });

  // late FocusNode _focusNode;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            offset: focusNode!.hasFocus ? Offset(MediaQuery.of(context).size.height * 0.008, MediaQuery.of(context).size.height * 0.008) : Offset(MediaQuery.of(context).size.height * 0.004, MediaQuery.of(context).size.height * 0.004),
            blurRadius: focusNode!.hasFocus ? MediaQuery.of(context).size.height * 0.018 : MediaQuery.of(context).size.height * 0.008,
            inset: true,
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            offset: focusNode!.hasFocus ? Offset(-MediaQuery.of(context).size.height * 0.008, -MediaQuery.of(context).size.height * 0.008) : Offset(-MediaQuery.of(context).size.height * 0.004, -MediaQuery.of(context).size.height * 0.004),
            blurRadius: focusNode!.hasFocus ? MediaQuery.of(context).size.height * 0.018 : MediaQuery.of(context).size.height * 0.008,
            inset: true,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.068,
      duration: const Duration(milliseconds: 100),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: TextStyle(color: _focusNode.hasFocus ? Colors.transparent : Theme.of(context).colorScheme.onSurface),
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
          obscureText: obscureText,
          cursorColor: Theme.of(context).colorScheme.onSurface,
          maxLines: null,
        ),
      ),
    );
  }
}