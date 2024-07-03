import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyButton extends StatefulWidget {
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? const Offset(5, 5) : const Offset(8, 8);
    double blur = isPressed ? 20 : 10;

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              blurRadius: blur,
              offset: -distance,
              color: const Color(0xFFFFFFFF),
              inset: isPressed,
            ),
            BoxShadow(
              blurRadius: blur,
              offset: distance,
              color: const Color(0xFFA7A9AF),
              inset: isPressed,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
