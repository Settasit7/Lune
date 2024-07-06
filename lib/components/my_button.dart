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
    final Offset offset = isPressed ? const Offset(4, 4) : const Offset(8, 8);
    final double blurRadius = isPressed ? 4 : 8;

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
        height: 64,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                offset: -offset,
                blurRadius: blurRadius,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiary,
                offset: offset,
                blurRadius: blurRadius,
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
                    width: 24,
                    height: 24,
                  ),
                if (widget.text != null) ...[
                  if (widget.icon != null)
                    const SizedBox(width: 12),
                  Text(
                    widget.text!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
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