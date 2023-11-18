import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;

  const AppTextFormField(
      {super.key,
      required this.label,
      required this.textEditingController,
      this.isObscure = false,
      required this.validator,
      this.keyboardType,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: isObscure,
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
