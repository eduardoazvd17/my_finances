import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData? icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode focusNode;
  final void Function(String?)? onSubmitted;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final bool autofocus;
  final int? maxLength;

  const TextFieldWidget({
    super.key,
    this.icon,
    required this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.textInputAction,
    this.onSubmitted,
    this.obscureText = false,
    this.autofillHints,
    this.autofocus = false,
    this.maxLength,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _hasFocus = false;
  bool _hasText = false;

  void _focusNodeListener() {
    setState(() {
      _hasFocus = widget.focusNode.hasFocus;
    });
  }

  void _controllerListener() {
    setState(() {
      _hasText = widget.controller.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    widget.focusNode.addListener(_focusNodeListener);
    widget.controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusNodeListener);
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          TextField(
            autofocus: widget.autofocus,
            autofillHints: widget.autofillHints,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: _hasFocus && _hasText
                  ? InkWell(
                      borderRadius: BorderRadius.circular(50),
                      child: const Icon(Icons.close),
                      onTap: () => widget.controller.clear(),
                    )
                  : (widget.icon != null)
                      ? Icon(widget.icon)
                      : null,
            ),
            focusNode: widget.focusNode,
            keyboardType: widget.textInputType,
            onSubmitted: widget.onSubmitted,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText,
            textCapitalization: widget.textCapitalization,
            maxLength: widget.maxLength,
          ),
        ],
      ),
    );
  }
}
