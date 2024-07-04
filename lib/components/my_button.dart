import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyButton extends StatefulWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
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
    Offset offset = isPressed ? const Offset(0, 0) : const Offset(8, 8);
    double blurRadius = isPressed ? 0 : 8;

    return Listener(
      onPointerUp: (_) {
        setState(() {
          isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onPointerDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      child: SizedBox(
        height: 64,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 64),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(256),
            boxShadow: [
              BoxShadow(
                blurRadius: blurRadius,
                offset: -offset,
                color: Theme.of(context).colorScheme.primary,
              ),
              BoxShadow(
                blurRadius: blurRadius,
                offset: offset,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
