import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      this.maxLines,
      required this.hintText,
      required this.controller});

  final int? maxLines; //최대 라인 수
  final String hintText; //힌트 텍스트
  final TextEditingController controller; //컨트롤러

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: true,
      minLines: null,
      maxLines: null,
      cursorColor: Colors.redAccent,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusColor: Colors.redAccent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        hintText: hintText,
      ),
    );
  }
}
