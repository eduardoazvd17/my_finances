import 'package:flutter/material.dart';
import '../../data/utils/app_themes.dart';
import 'scroll_view_widget.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 5,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppThemes.commonColor,
                  ),
                ),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) _headerIcon(context),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            title!,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (icon != null)
                        Visibility(
                          visible: false,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: _headerIcon(context),
                        ),
                    ],
                  ),
                ),
              if (title != null) const Divider(),
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

  Widget _headerIcon(BuildContext context) {
    return Icon(
      icon,
      size: 25 * MediaQuery.of(context).textScaleFactor,
    );
  }
}
