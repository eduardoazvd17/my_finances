import 'package:flutter/material.dart';

class ListHeaderWidget extends StatelessWidget {
  final String title;
  final Widget? action;
  final Widget? content;
  final bool expandedContent;

  const ListHeaderWidget({
    super.key,
    required this.title,
    this.action,
    this.content,
    this.expandedContent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              if (action != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: action,
                ),
            ],
          ),
        ),
        const Divider(),
        if (content != null)
          expandedContent ? Expanded(child: content!) : content!,
      ],
    );
  }
}
