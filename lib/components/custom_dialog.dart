import 'dart:math';

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
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: min(
            MediaQuery.of(context).size.width * 0.652,
            MediaQuery.of(context).size.height * 0.652,
          ),
          maxHeight: min(
            MediaQuery.of(context).size.width * 0.652,
            MediaQuery.of(context).size.height * 0.652,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.502,
                height: MediaQuery.of(context).size.height * 0.232,
                child: Image.asset('assets/images/aru_sticker.png'),
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}