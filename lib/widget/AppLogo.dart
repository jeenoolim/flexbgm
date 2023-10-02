import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          size: 40,
          color: Colors.redAccent,
          FontAwesomeIcons.music,
        ),
        Text(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          'FLEX BGM',
        ),
      ],
    );
  }
}
