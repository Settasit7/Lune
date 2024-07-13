import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyButton extends StatefulWidget {
  final void Function()? onTap;
  final String? icon;
  final String? text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.068,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                offset: isPressed ? Offset(-MediaQuery.of(context).size.height * 0.004, -MediaQuery.of(context).size.height * 0.004) : Offset(-MediaQuery.of(context).size.height * 0.008, -MediaQuery.of(context).size.height * 0.008),
                blurRadius: isPressed ? MediaQuery.of(context).size.height * 0.004 : MediaQuery.of(context).size.height * 0.008,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiary,
                offset: isPressed ? Offset(MediaQuery.of(context).size.height * 0.004, MediaQuery.of(context).size.height * 0.004) : Offset(MediaQuery.of(context).size.height * 0.008, MediaQuery.of(context).size.height * 0.008),
                blurRadius: isPressed ? MediaQuery.of(context).size.height * 0.004 : MediaQuery.of(context).size.height * 0.008,
              ),
            ],
          ),
          duration: const Duration(milliseconds: 50),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Image.asset(
                    widget.icon!,
                    width: min(
                      MediaQuery.of(context).size.width * 0.056,
                      MediaQuery.of(context).size.height * 0.026,
                    ),
                    height: min(
                      MediaQuery.of(context).size.width * 0.056,
                      MediaQuery.of(context).size.height * 0.026,
                    ),
                  ),
                if (widget.text != null) ...[
                  if (widget.icon != null)
                    const SizedBox(width: 8),
                  Text(
                    widget.text!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}