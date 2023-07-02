import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmitted;
  final bool obscureText;

  const TextFieldWidget({
    super.key,
    this.icon,
    required this.label,
    required this.hint,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: icon != null ? Icon(icon) : null,
            ),
            focusNode: focusNode,
            keyboardType: textInputType,
            onSubmitted: onSubmitted,
            textInputAction: textInputAction,
            obscureText: obscureText,
            textCapitalization: textCapitalization,
          ),
        ],
      ),
    );
  }
}
