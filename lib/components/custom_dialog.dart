import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;

  const CustomDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 280,
          maxHeight: 280,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                      width: 216,
                      height: 216,
                      child: Image.asset('assets/images/aru_sticker.png'),
                    ),
                    const SizedBox(width: 16),
                ],
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}