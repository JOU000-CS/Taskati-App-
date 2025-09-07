import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, this.hint, this.validator, required this.controller,  this.maxLines = 1, this.suffixIcon , this.readOnly = true, this.onTap
  });

  final String? hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon
      ),
    );
  }
}