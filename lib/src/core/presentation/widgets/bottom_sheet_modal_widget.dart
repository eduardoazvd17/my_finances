import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';

class BottomSheetModalWidget extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  const BottomSheetModalWidget({
    super.key,
    required this.child,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: _closeButton,
                  ),
                  Container(
                    height: 8,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[600],
                    ),
                  ),
                  _closeButton,
                ],
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(icon),
                        ),
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              Flexible(
                child: ScrollViewWidget(
                  showBar: true,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _closeButton => IconButton(
        onPressed: Get.back,
        tooltip: 'close-button'.i18n(),
        icon: const Icon(Icons.close, color: Colors.red),
      );
}
