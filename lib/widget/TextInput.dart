import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      this.maxLines,
      this.enabled,
      this.onChanged,
      this.onTap,
      this.errorText,
      this.labelText,
      this.hintText,
      required this.controller});

  final int? maxLines; //최대 라인 수
  final String? hintText; //힌트 텍스트
  final String? errorText;
  final String? labelText;
  final TextEditingController controller; //컨트롤러
  final bool? enabled;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      controller: controller,
      expands: true,
      minLines: null,
      maxLines: null,
      onChanged: onChanged,
      onTap: onTap,
      cursorColor: Colors.redAccent,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        errorStyle: const TextStyle(height: 0.1),
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
