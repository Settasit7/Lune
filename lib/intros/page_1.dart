import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.034),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    offset: Offset(-MediaQuery.of(context).size.height * 0.008, -MediaQuery.of(context).size.height * 0.008),
                    blurRadius: MediaQuery.of(context).size.height * 0.008,
                  ),
                  BoxShadow(
                    color: Theme.of(context).colorScheme.tertiary,
                    offset: Offset(MediaQuery.of(context).size.height * 0.008, MediaQuery.of(context).size.height * 0.008),
                    blurRadius: MediaQuery.of(context).size.height * 0.008,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}